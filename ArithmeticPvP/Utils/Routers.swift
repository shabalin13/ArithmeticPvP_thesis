//
//  Router.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol ProfileRouterProtocol: RouterProtocol {
    func initialViewController()
    func showSettings()
    func showSignIn()
    func popToRoot()
}

protocol SkinsRouterProtocol: RouterProtocol {
    func initialViewController()
}

protocol GameRouterProtocol: RouterProtocol {
    func initialViewController()
    func goToWaitingRoom()
    func goToWaitingRoomAgain()
    func startGame(players: [Player])
    func showPostGameStatistics()
    func backToPrevious()
    func popToRoot()
}


class ProfileRouter: ProfileRouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let profileViewController = assemblyBuilder?.createProfileModule(router: self) else { return }
            navigationController.viewControllers = [profileViewController]
        }
    }
    
    func showSettings() {
        if let navigationController = navigationController {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self) else { return }
            navigationController.pushViewController(settingsViewController, animated: true)
        }
    }
    
    func showSignIn() {
        if let navigationController = navigationController {
            guard let signInViewController = assemblyBuilder?.createSignInModule(router: self) else { return }
            navigationController.pushViewController(signInViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}


class SkinsRouter: SkinsRouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let skinsViewController = assemblyBuilder?.createSkinsModule(router: self) else { return }
            navigationController.viewControllers = [skinsViewController]
        }
    }
    
}


class GameRouter: GameRouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let startGameViewController = assemblyBuilder?.createStartGameModule(router: self) else { return }
            navigationController.viewControllers = [startGameViewController]
        }
    }
    
    func goToWaitingRoom() {
        if let navigationController = navigationController {
            guard let waitingRoomViewController = assemblyBuilder?.createWaitingRoomModule(router: self) else { return }
            navigationController.pushViewController(waitingRoomViewController, animated: true)
        }
    }
    
    func goToWaitingRoomAgain() {
        popToRoot()
        if let navigationController = navigationController {
            guard let waitingRoomViewController = assemblyBuilder?.createWaitingRoomModule(router: self) else { return }
            navigationController.pushViewController(waitingRoomViewController, animated: true)
        }
    }
    
    func startGame(players: [Player]) {
        if let navigationController = navigationController {
            guard let gameViewController = assemblyBuilder?.createGameModule(router: self, players: players) else { return }
            navigationController.pushViewController(gameViewController, animated: true)
        }
    }
    
    func showPostGameStatistics() {
        if let navigationController = navigationController {
            guard let postGameStatisticsViewController = assemblyBuilder?.createPostGameStatisticsModule(router: self) else { return }
            navigationController.pushViewController(postGameStatisticsViewController, animated: true)
        }
    }
    
    func backToPrevious() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
