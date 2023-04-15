//
//  Assembly.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController
    func createSignInModule(router: ProfileRouterProtocol) -> UIViewController
    func createSettingsModule(router: ProfileRouterProtocol) -> UIViewController
    
    func createSkinsModule(router: SkinsRouterProtocol) -> UIViewController
    
    func createStartGameModule(router: GameRouterProtocol) -> UIViewController
    func createWaitingRoomModule(router: GameRouterProtocol) -> UIViewController
    func createGameModule(router: GameRouterProtocol, players: [Player]) -> UIViewController
    func createPostGameStatisticsModule(router: GameRouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createProfileModule(router: ProfileRouterProtocol) -> UIViewController {
        let viewModel = ProfileViewModel(router: router)
        let view = ProfileViewController(viewModel: viewModel)
        return view
    }
    
    func createSignInModule(router: ProfileRouterProtocol) -> UIViewController {
        let viewModel = SignInViewModel(router: router)
        let view = SignInViewController(viewModel: viewModel)
        return view
    }
    
    func createSettingsModule(router: ProfileRouterProtocol) -> UIViewController {
        let viewModel = SettingsViewModel(router: router)
        let view = SettingsViewController(viewModel: viewModel)
        return view
    }
    
    func createSkinsModule(router: SkinsRouterProtocol) -> UIViewController {
        let viewModel = SkinsViewModel(router: router)
        let view = SkinsViewController(viewModel: viewModel)
        return view
    }
    
    func createStartGameModule(router: GameRouterProtocol) -> UIViewController {
        let viewModel = StartGameViewModel(router: router)
        let view = StartGameViewController(viewModel: viewModel)
        return view
    }
    
    func createWaitingRoomModule(router: GameRouterProtocol) -> UIViewController {
        let viewModel = WaitingRoomViewModel(router: router)
        let view = WaitingRoomViewController(viewModel: viewModel)
        return view
    }
    
    func createGameModule(router: GameRouterProtocol, players: [Player]) -> UIViewController {
        let viewModel = GameViewModel(router: router, players: players)
        let view = GameViewController(viewModel: viewModel)
        return view
    }
    
    func createPostGameStatisticsModule(router: GameRouterProtocol) -> UIViewController {
        let viewModel = PostGameStatisticsViewModel(router: router)
        let view = PostGameStatisticsViewController(viewModel: viewModel)
        return view
    }
    
}
