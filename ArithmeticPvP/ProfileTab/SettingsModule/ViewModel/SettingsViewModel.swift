//
//  SettingsViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import Foundation

protocol SettingsViewModelProtocol {
    
    var state: Observable<SettingsState> { get set }
    var router: ProfileRouterProtocol { get set }
    
    func updateState()
    
    func getUserInfo(cookie: String)
    func changeUsername(with username: String?)
    func logOut()
}


class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Class Properties
    var state: Observable<SettingsState> = Observable(.initial)
    var router: ProfileRouterProtocol
    
    // MARK: - Init
    init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Updating state
    func updateState() {
        if let cookie = UserDefaultsHelper.shared.getCookie() {
            self.getUserInfo(cookie: cookie)
        } else {
            self.state.value = .notRegistered
        }
    }
    
    // MARK: - Func for getting information about the user
    func getUserInfo(cookie: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            NetworkService.shared.getUserInfo(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    let settingsData = SettingsData(username: user.username, email: user.email)
                    self.state.value = .registered(settingsData)
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    // MARK: - Func for changing username
    func changeUsername(with username: String?) {
        guard let newUsername = username, let cookie = UserDefaultsHelper.shared.getCookie() else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
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
    
    // MARK: - Func for Logging Out
    func logOut() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            GoogleService.shared.logOutFromGoogle { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    NetworkService.shared.logOut { [weak self] result in
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
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
}
