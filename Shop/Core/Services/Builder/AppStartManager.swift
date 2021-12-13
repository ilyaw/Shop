//
//  AppStartManager.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

final class AppStartManager {
    
    private var window: UIWindow?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let rootVC = MainBuilder.build()

        rootVC.navigationItem.title = "Main screen"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }()
}
