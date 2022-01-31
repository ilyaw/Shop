//
//  AppStartRouter.swift
//  Shop
//
//  Created by Ilya on 23.01.2022.
//

import UIKit

protocol StartRouter: AnyObject {
    var onShowMainScreen: VoidClouser? { get set }
    func showLoaderScreen()
    func showAuth()
    func showSignUp()
    func startMainScreen()
}

final class AppStartRouter {
    
    // MARK: - Public properties
    
    var onShowMainScreen: VoidClouser?
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        window.makeKeyAndVisible()

        if AppData.accessToken.isEmpty {
            self.showAuth()
        } else {
            self.showLoaderScreen()
        }
    }
    
    func removeNavigationStack() {
        navigationController.viewControllers = []
    }

    deinit {
       print("deinit AppStartRouter")
    }
}

// MARK: - AppStartRouter + StartRouter

extension AppStartRouter: StartRouter {
    func showLoaderScreen() {
        let controller = Builders.loadScreenBuild(router: self)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func showAuth() {
        let controller = Builders.authBuild(router: self)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func showSignUp() {
        let controller = Builders.signUpBuild(router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startMainScreen() {
        onShowMainScreen?()
    }
}
