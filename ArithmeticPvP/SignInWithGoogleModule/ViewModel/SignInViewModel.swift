//
//  SignInViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 15.03.2023.
//

import Foundation

protocol SignInViewModelProtocol {
    var state: Observable<SignInState> { get set }
    var router: ProfileRouterProtocol { get set }
    func signInWithGoogleButtonTapped(presentingVC: SignInViewController)
}

class SignInViewModel: SignInViewModelProtocol {
    
    // MARK: - SignInViewModel properties
    var state: Observable<SignInState> = Observable(.initial)
    var router: ProfileRouterProtocol
    
    // MARK: - Init
    init(router: ProfileRouterProtocol) {
        self.router = router
        state.value = .notRegistered
    }
    
    // MARK: - Sign In With Google
    func signInWithGoogleButtonTapped(presentingVC: SignInViewController) {
        print("SignInViewModelProtocol.signInWithGoogleButtonTapped - \(Thread.current)")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            print("SignInViewModelProtocol.signInWithGoogleButtonTapped.Task - \(Thread.current)")
            GoogleService.shared.signInWithGoogle(presentingVC: presentingVC) { [weak self] result in
                guard let self = self else { return }
                print("completion - \(Thread.current)")
                switch result {
                case .success(let idToken):
                    DispatchQueue.global().async { [weak self] in
                        guard let self = self else { return }
                        print("NetworkService.shared.logIn - \(Thread.current)")
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
                                print(error)
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
