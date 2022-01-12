//
//  AppManager.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

typealias BoolClouser = ((Bool) -> Void)
typealias VoidClouser = (() -> Void)

final class AppManager {
    private let window: UIWindow
    private var appStartRouter: AppStartRouter?
    private var mainTabbar: MainTabBarController?

    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
    }
    
    func start() {
        mainTabbar?.removeNavigationStack()
        mainTabbar = nil
        
        appStartRouter = AppStartRouter(window: window)
        appStartRouter?.start()
        
        appStartRouter?.onShowMainScreen = { [weak self] in
            self?.startMainScreen()
        }
    }
    
    func startMainScreen() {
        appStartRouter?.removeNavigationStack()
        appStartRouter = nil
        
        mainTabbar = MainTabBarController()
        
        mainTabbar?.signOut = {
            self.start()
            UIView.transition(with: self.window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
            print("sign out")
        }
        
        mainTabbar?.setupVCs()
                
        self.window.rootViewController = mainTabbar

        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.curveLinear, .transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
}

protocol StartRouter: AnyObject {
    var onShowMainScreen: VoidClouser? { get set }
    func showAuth()
    func showSignUp()
    func startMainScreen()
}

final class AppStartRouter {

    var onShowMainScreen: VoidClouser?
    let navigationController: UINavigationController
    
    required init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        checkNetwork { [weak self] in
            if AppData.accessToken.isEmpty {
                self?.showAuth()
            } else {
                self?.onShowMainScreen?()
            }
        }
    }
    
    func removeNavigationStack() {
        navigationController.viewControllers = []
    }
    
    // MARK: - Private methods
    
    private func checkNetwork(completion: @escaping VoidClouser) {
        let baseURL = BaseURL()
        
        baseURL.url.сheckWebsiteAvailability { [weak self] isAvailability in
            if isAvailability {
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    let noConnectionController = NoConnectionBuilder.build(completion: completion)
                    self?.navigationController.pushViewController(noConnectionController, animated: true)
                }
            }
        }
    }
    
    deinit {
        print("deinit AppStartRouter")
    }
}

// MARK: - AppStartRouter + StartRouter

extension AppStartRouter: StartRouter {
    func showAuth() {
        let controller = AuthBuilder.build(router: self)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func showSignUp() {
        let controller = SignUpBuilder.build(router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startMainScreen() {
        onShowMainScreen?()
    }
}
