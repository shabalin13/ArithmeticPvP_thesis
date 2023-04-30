//
//  AppleService.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 28.04.2023.
//

import Foundation
import CryptoKit
//import FirebaseCore
import FirebaseAuth
import AuthenticationServices

class AppleService {
    
    static let shared = AppleService()
    
    fileprivate var currentNonce: String?
    
    enum AppleServiceError: Error, LocalizedError {
        case failedToSignIn
        case failedToLogOut
    }
    
    func signInWithApple(presentingVC: SignInViewController) {
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = presentingVC
        authorizationController.presentationContextProvider = presentingVC
        authorizationController.performRequests()
        
    }
    
    func signedInWithApple(appleIDCredential: ASAuthorizationAppleIDCredential, completion: @escaping (Result<String, AppleServiceError>) -> Void) {
        
        guard let nonce = AppleService.shared.currentNonce else {
            completion(.failure(.failedToSignIn))
            return
        }
        
        guard let appleIDToken = appleIDCredential.identityToken else {
            completion(.failure(.failedToSignIn))
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            completion(.failure(.failedToSignIn))
            return
        }
        
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let _ = error {
                completion(.failure(.failedToSignIn))
                return
            }

            Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
                if error != nil {
                    completion(.failure(.failedToSignIn))
                    return
                } else if let idToken = idToken {
                    completion(.success(idToken))
                    return
                }
            })
        }
    }
    
    func logOutFromApple(completion: @escaping (Result<Void, AppleServiceError>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToLogOut))
            return
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
}

extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            viewModel.signedInWithApple(appleIDCredential: appleIDCredential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        viewModel.state.value = .error(AppleService.AppleServiceError.failedToSignIn)
    }
    
}
