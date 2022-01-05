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
    
    // MARK: - Private properties
    
    private lazy var checkAccessToken: Bool = {
        KeychainWrapper.standard.string(forKey: AppConstant.keychainAccessTokenKey) == nil ? false : true
    }()
    
    // MARK: - Public methods
    
    func start() {
        let baseURL = BaseURL()
        
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
        if self.checkAccessToken {
            let tabbar = MainTabBar()
            UIApplication.setRootVC(viewController: tabbar)
        } else {
            let auth = AuthBuilder.build()
            UIApplication.setRootVC(viewController: auth)
        }
    }
}
