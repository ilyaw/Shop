//
//  AppStartManager.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit
import Network
import SwiftKeychainWrapper

final class AppStartManager {
    
//    private var window: UIWindow?
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }()
    
//    init(windowScene: UIWindowScene) {
//        self.window = UIWindow(windowScene: windowScene)
//    }
    
    func start() {
        
        let baseURL = BaseURL()
        
        baseURL.url.сheckWebsiteAvailability { isOk in
            
            if isOk {
                DispatchQueue.main.async {
                    let tabbar = BaseTabBar()
                    UIApplication.setRootVC(viewController: tabbar)
                }
            } else {
                DispatchQueue.main.async {
                    let noConnectionController = NoConnectionBuilder.build()
                    UIApplication.setRootVC(viewController: noConnectionController)
                }
            }
            
            //            DispatchQueue.main.async {
            //                let rootConrtoller = AuthBuilder.build()
            //
            //                rootConrtoller.navigationItem.title = "Main screen"
            //
            //                let navVC = self.configuredNavigationController
            //                navVC.viewControllers = [rootConrtoller]
            //
            //
            ////                self.setRootVC(viewController: tabbar)
            //
            //            }
        }
        
        //
        //        let noConnectionController = NoConnectionViewController()
        //        self.window?.rootViewController = noConnectionController
        //        self.window?.makeKeyAndVisible()
        
        //      let baseURL = BaseURL()
        //        checkWebsite(url: baseURL.urlString) { [weak self] status in
        //            guard let self = self else { return }
        //            if status {
        //
        //            } else {
        //
        //            }
        //        }
    }
}
