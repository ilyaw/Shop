//
//  ProfileRouter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

// MARK: - Profile Router

class ProfileRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func openSettings() {
//        let changeProfileController = Builders.changeProfileBuild(navigationController: navigationController)
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .systemBlue
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            vc.dismiss(animated: true, completion: nil)
        }
        
        navigationController.present(vc, animated: true)
    }
    
}
