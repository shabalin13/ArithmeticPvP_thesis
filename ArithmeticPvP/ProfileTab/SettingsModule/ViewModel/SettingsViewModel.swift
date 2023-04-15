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
        if let _ = UserDefaultsHelper.shared.getCookie() {
            self.state.value = .registered
        } else {
            self.state.value = .notRegistered
        }
    }
    
    // MARK: - Func for Log Out
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
