//
//  MainTabBarController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var signOut: VoidClouser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UITabBar.appearance().barTintColor = .systemBackground
        //        tabBar.tintColor = .label
        //        setupVCs()
    }
        
    func setupVCs() {
        let homeNavigation = createNavController(title: "Home", image: UIImage(systemName: "house"))
        let cartNavigation = createNavController(title: "Cart", image: UIImage(systemName: "cart"))
        let profileNavigation = createNavController(title: "Profile", image: UIImage(systemName: "person"))
        
//        let homeController = Builders.homeBuild(navigationController: homeNavigation)
//        let cartController = Builders.cartBuild(navigationController: cartNavigation)
//        let profileController = Builders.profileBuild(navigationController: profileNavigation, signOut: signOut)
//
//        homeNavigation.setViewControllers([homeController], animated: true)
//        cartNavigation.setViewControllers([cartController], animated: true)
//        profileNavigation.setViewControllers([profileController], animated: true)
//
//        viewControllers = [
//            homeNavigation, cartNavigation, profileNavigation
//        ]
    }
    
    private func createNavController(title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func removeNavigationStack() {
        guard let controllers = viewControllers else { return }
        
        for controller in controllers {
            if let controller = controller as? UINavigationController {
                controller.viewControllers.removeAll()
            }
        }
    }
    
    deinit {
        print("deinit MainTabBarController")
    }
}
