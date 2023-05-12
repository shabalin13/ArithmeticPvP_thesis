//
//  EmailService.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.05.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class EmailService {
    
    static let shared = EmailService()
    
    enum EmailServiceError: Error, LocalizedError {
        case failedToSignIn
        case failedToLogOut
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<String, EmailServiceError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
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
                }
            })

        }
    }
    
    func logOutFromEmail(completion: @escaping (Result<Void, EmailServiceError>) -> Void) {
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
