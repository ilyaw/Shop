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
    }
    
    func start() {
        mainTabbar?.removeNavigationStack()
        mainTabbar = nil
        
        appStartRouter = AppStartRouter(window: window)
        appStartRouter?.onShowMainScreen = { [weak self] in
            self?.startMainScreen()
        }
        
        appStartRouter?.start()
    }
    
    func startMainScreen() {
        appStartRouter?.removeNavigationStack()
        appStartRouter = nil
        
        mainTabbar = MainTabBarController()
        
        mainTabbar?.signOut = {
            AppData.accessToken = ""
            AppData.username = ""
            
            self.start()
            UIView.transition(with: self.window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
        }
        
        mainTabbar?.setupVCs()
        
        self.window.rootViewController = mainTabbar
        
        if !self.window.isKeyWindow {
            self.window.makeKeyAndVisible()
        }
        
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
    let window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
    }
    
    // MARK: - Public methods
    
    func start() {
        if AppData.accessToken.isEmpty {
            self.showAuth()
        } else {
            self.onShowMainScreen?()
        }
        
        // TODO: Подумать куда вынести
        //        checkNetwork { [weak self] in
        //            if AppData.accessToken.isEmpty {
        //                self?.showAuth()
        //            } else {
        //                self?.onShowMainScreen?()
        //            }
        //        }
    }
    
    func removeNavigationStack() {
        navigationController.viewControllers = []
    }
    
    // TODO: Подумать куда вынести
    //    private func checkNetwork(completion: @escaping VoidClouser) {
    //        let baseURL = BaseURL()
    //        completion()
    //        //        baseURL.url.сheckWebsiteAvailability { [weak self] isAvailability in
    //        //            if isAvailability {
    //        //                DispatchQueue.main.async {
    //        //                    completion()
    //        //                }
    //        //            } else {
    //        //                DispatchQueue.main.async {
    //        //                    let noConnectionController = NoConnectionBuilder.build(completion: completion)
    //        //                    self?.navigationController.pushViewController(noConnectionController, animated: true)
    //        //                }
    //        //            }
    //        //        }
    //    }
    
    deinit {
        print("deinit AppStartRouter")
    }
}

// MARK: - AppStartRouter + StartRouter

extension AppStartRouter: StartRouter {
    func showAuth() {
        window.makeKeyAndVisible()
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
