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
            AppData.fullName = ""
            
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
