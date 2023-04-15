//
//  GoogleService.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import FirebaseAuth

class GoogleService {
    
    static let shared = GoogleService()
    
    enum GoogleServiceError: Error, LocalizedError {
        case failedToSignIn
        case failedToLogOut
    }
    
    func signInWithGoogle(presentingVC: SignInViewController, completion: @escaping (Result<String, GoogleServiceError>) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(.failedToSignIn))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
                guard error == nil else {
                    completion(.failure(.failedToSignIn))
                    return
                }
                
                guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                    completion(.failure(.failedToSignIn))
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { result, error in
                    guard error == nil else {
                        completion(.failure(.failedToSignIn))
                        return
                    }
                    
                    Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
                        if error != nil {
                            completion(.failure(.failedToSignIn))
                            return
                        } else if let idToken = idToken {
                            completion(.success(idToken))
                        }
                    })
                }
            }
        }
    }
    
    func logOutFromGoogle(completion: @escaping (Result<Void, GoogleServiceError>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToLogOut))
            return
        }
    }
    
}
