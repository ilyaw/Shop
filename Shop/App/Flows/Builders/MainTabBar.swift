//
//  MainTabBar.swift
//  Shop
//
//  Created by Ilya on 04.01.2022.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: AuthBuilder.build(),
                                   title: NSLocalizedString("Главная", comment: ""),
                                   image: UIImage(systemName: "house") ?? UIImage()),
            createNavController(for: AuthBuilder.build(),
                                   title: NSLocalizedString("Корзина", comment: ""),
                                   image: UIImage(systemName: "cart") ?? UIImage()),
            createNavController(for: AuthBuilder.build(),
                                   title: NSLocalizedString("Профиль", comment: ""),
                                   image: UIImage(systemName: "person") ?? UIImage())
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
