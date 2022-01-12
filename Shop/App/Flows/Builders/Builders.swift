//
//  Builders.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class Builders {
    
    static func authBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeAuthRequestFatory()
        let presenter = AuthPresenter(router: router, requestFactory: requestFactory)
        let viewController = AuthViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
    
    static func signUpBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let presenter = SignUpPresenter(router: router, requestFactory: requestFactory)
        let viewController = SignUpViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
    
    static func homeBuild(navigationController: UINavigationController) -> UIViewController {
        let router = HomeRouter(navigationController: navigationController)
        let homeController = HomeViewController()
        homeController.presenter = HomePresenter(router: router)
        return homeController
    }
    
    static func cartBuild(navigationController: UINavigationController) -> UIViewController {
        let cartController = CartViewController()
        return cartController
    }
    
    static func profileBuild(navigationController: UINavigationController, signOut: VoidClouser?) -> UIViewController {
        let router = ProfileRouter(navigationController: navigationController)
        let profileController = ProfileViewController()
        let presenter = ProfilePresenter(router: router)
        presenter.signOut = signOut
        profileController.presenter = presenter
        return profileController
    }
    
    static func catalogBuild(navigationController: UINavigationController) -> UIViewController {
        let router = HomeRouter(navigationController: navigationController)
        let catalogController = CatalogViewController()
        catalogController.presenter = CatalogPresenter(router: router)
        return catalogController
    }
    
    static func productBuild(navigationController: UINavigationController) -> UIViewController {
        let productController = ProductViewController()
        return productController
    }
    
    static func noConnectionBuild(completion: @escaping VoidClouser) -> UIViewController {
       let viewController = NoConnectionViewController()
       viewController.connectionWasRestored = completion
       return viewController
   }
}
