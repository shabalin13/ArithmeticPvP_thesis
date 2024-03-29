//
//  TabBarViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem {
        case profile, skins, game
        
        var title: String {
            switch self {
            case .profile:
                return "Profile"
            case .skins:
                return "Skins"
            case .game:
                return "Game"
            }
        }
        
        var iconName: String {
            switch self {
            case .profile:
                return "person.fill"
            case .skins:
                return "theatermasks.fill"
            case .game:
                return "gamecontroller.fill"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.game, .skins, .profile]
        
        viewControllers = dataSource.map {
            switch $0 {
            case .profile:
                let navigationController = UINavigationController()
                let assemblyBuilder = AssemblyBuilder()
                let router = ProfileRouter(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
                router.initialViewController()
                return navigationController
            case .skins:
                let navigationController = UINavigationController()
                let assemblyBuilder = AssemblyBuilder()
                let router = SkinsRouter(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
                router.initialViewController()
                return navigationController
            case .game:
                let navigationController = UINavigationController()
                let assemblyBuilder = AssemblyBuilder()
                let router = GameRouter(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
                router.initialViewController()
                return navigationController
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
        }
        
        selectedIndex = dataSource.count - 1
    }

}
