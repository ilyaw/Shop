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

    // MARK: - Public methods
    
    func start() {
        let baseURL = BaseURL()
        
//        AppData.accessToken = ""
        
        baseURL.url.сheckWebsiteAvailability { isAvailability in
            if isAvailability {
                DispatchQueue.main.async {
                    self.presentScreen()
                }
            } else {
                DispatchQueue.main.async {
                    let noConnectionController = NoConnectionBuilder.build()
                    UIApplication.setRootVC(viewController: noConnectionController)
                }
            }
        }
    }
    
    public func presentScreen() {
        if AppData.accessToken.isEmpty {
            let auth = AuthBuilder.build()
            UIApplication.setRootVC(viewController: auth)
        } else {
            let tabbar = MainTabBar()
            UIApplication.setRootVC(viewController: tabbar)
        }
    }
}
