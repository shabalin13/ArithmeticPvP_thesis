//
//  StartGameViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import Foundation

protocol StartGameViewModelProtocol {
    
    var state: Observable<StartGameState> { get set }
    var router: GameRouterProtocol { get set }
    
    func updateState()
    func goToWaitingRoom()
}

class StartGameViewModel: StartGameViewModelProtocol {
    
    // MARK: - Class Properties
    var state: Observable<StartGameState> = Observable(.initial)
    var router: GameRouterProtocol
    
    // MARK: - Init
    init(router: GameRouterProtocol) {
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
    
    // MARK: - Func for going to Waiting Room
    func goToWaitingRoom() {
        router.goToWaitingRoom()
    }
}
