//
//  ProfileViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var state: Observable<ProfileState> { get set }
    var router: ProfileRouterProtocol { get set }
    func settingButtonTapped()
    func signInButtonTapped()
    func changeUsernameButtonTapped(with username: String?)
    func statisticsButtonTapped()
    func checkState()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    // MARK: - ProfileViewModel properties
    var state: Observable<ProfileState> = Observable(.initial)
    var router: ProfileRouterProtocol
    
    // MARK: - Init
    init(router: ProfileRouterProtocol) {
        self.router = router
//        UserDefaultsHelper.shared.removeCookie()
    }
    
    // MARK: - Profile state checking
    func checkState() {
        if let cookie = UserDefaultsHelper.shared.getCookie() {
            getUserInfo(cookie: cookie)
        } else {
            self.state.value = .notRegistered
        }
    }
    
    // MARK: - Functions
    private func getUserInfo(cookie: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            NetworkService.shared.getUserInfo(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.state.value = .registered(user)
                    NetworkService.shared.getSkinImage(from: user.currentSkin.imageURL) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let imageData):
                            var newUser = user
                            newUser.currentSkinData = imageData
                            self.state.value = .registered(newUser)
                        case .failure(let error):
                            print(error)
                        }
                    }
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    func changeUsernameButtonTapped(with username: String?) {
        guard let newUsername = username else {
            //self.state.value = .error(<#T##Error#>)
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            guard let cookie = UserDefaultsHelper.shared.getCookie() else {
                //self.state.value = .error(<#T##Error#>)
                return
            }
            NetworkService.shared.changeUsername(cookie: cookie, newUsername: newUsername) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.getUserInfo(cookie: cookie)
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    func settingButtonTapped() {
        router.showSettings()
    }
    
    func signInButtonTapped() {
        router.showSignIn()
    }
    
    func statisticsButtonTapped() {
        print("cookie: \(UserDefaultsHelper.shared.getCookie() ?? "")")
        print("expiryDate: \(UserDefaultsHelper.shared.getExpiryDate())")
    }
    
}
