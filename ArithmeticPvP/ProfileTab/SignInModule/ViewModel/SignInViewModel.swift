//
//  SignInViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 15.03.2023.
//

import Foundation
import AuthenticationServices

protocol SignInViewModelProtocol {
    var state: Observable<SignInState> { get set }
    var router: ProfileRouterProtocol { get set }
    
    func updateState()
    
    func signInWithGoogleButtonTapped(presentingVC: SignInViewController)
    
    func signInWithApple(presentingVC: SignInViewController)
    func signedInWithApple(appleIDCredential: ASAuthorizationAppleIDCredential)
    func signInWithEmail(email: String, password: String)
}

class SignInViewModel: SignInViewModelProtocol {
    
    // MARK: - Class Properties
    var state: Observable<SignInState> = Observable(.initial)
    var router: ProfileRouterProtocol
    
    // MARK: - Init
    init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Updating state
    func updateState() {
        self.state.value = .notRegistered
    }
    
    // MARK: - Sign In With Google
    func signInWithGoogleButtonTapped(presentingVC: SignInViewController) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            GoogleService.shared.signInWithGoogle(presentingVC: presentingVC) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let idToken):
                    DispatchQueue.global().async { [weak self] in
                        guard let self = self else { return }
                        self.state.value = .loading
                        NetworkService.shared.logIn(idToken: idToken) { [weak self ]result in
                            guard let self = self else { return }
                            switch result {
                            case .success:
                                DispatchQueue.main.async { [weak self] in
                                    guard let self = self else { return }
                                    self.router.popToRoot()
                                }
                            case .failure(let error):
                                self.state.value = .error(error)
                            }
                        }
                    }
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    // MARK: - Sign In With Apple
    func signInWithApple(presentingVC: SignInViewController) {
        AppleService.shared.signInWithApple(presentingVC: presentingVC)
    }
    
    func signedInWithApple(appleIDCredential: ASAuthorizationAppleIDCredential) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            AppleService.shared.signedInWithApple(appleIDCredential: appleIDCredential) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let idToken):
                    DispatchQueue.global().async { [weak self] in
                        guard let self = self else { return }
                        self.state.value = .loading
                        NetworkService.shared.logIn(idToken: idToken) { [weak self ]result in
                            guard let self = self else { return }
                            switch result {
                            case .success:
                                DispatchQueue.main.async { [weak self] in
                                    guard let self = self else { return }
                                    self.router.popToRoot()
                                }
                            case .failure(let error):
                                self.state.value = .error(error)
                            }
                        }
                    }
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            EmailService.shared.signInWithEmail(email: email, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let idToken):
                    DispatchQueue.global().async { [weak self] in
                        guard let self = self else { return }
                        NetworkService.shared.logIn(idToken: idToken) { [weak self ]result in
                            guard let self = self else { return }
                            switch result {
                            case .success:
                                DispatchQueue.main.async { [weak self] in
                                    guard let self = self else { return }
                                    self.router.popToRoot()
                                }
                            case .failure(let error):
                                self.state.value = .error(error)
                            }
                        }
                    }
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
}
