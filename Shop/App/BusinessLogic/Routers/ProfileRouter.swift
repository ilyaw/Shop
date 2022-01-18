//
//  ProfileRouter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

// MARK: - Profile Router

class ProfileRouter {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let signOut: VoidClouser?
    
    // MARK: - Inits
    
    init(navigationController: UINavigationController, signOut: VoidClouser?) {
        self.navigationController = navigationController
        self.signOut = signOut
    }

    // MARK: - Public methods
    
    func openSettings() {
        let settingsController = Builders.settingsBuild(signOut: signOut)
        settingsController.modalPresentationStyle = .fullScreen
        
        navigationController.present(settingsController, animated: true)
    }
}
