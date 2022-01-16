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
        let controller = AuthViewController(presenter: presenter)
        presenter.viewInput = controller
        return controller
    }
    
    static func signUpBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let presenter = SignUpPresenter(router: router, requestFactory: requestFactory)
        let controller = SignUpViewController(presenter: presenter)
        presenter.viewInput = controller
        return controller
    }
    
    static func homeBuild(navigationController: UINavigationController) -> UIViewController {
        let router = HomeRouter(navigationController: navigationController)
        let controller = HomeViewController()
        controller.presenter = HomePresenter(router: router)
        return controller
    }
    
    static func cartBuild(navigationController: UINavigationController) -> UIViewController {
        let controller = CartViewController()
        return controller
    }
    
    static func profileBuild(navigationController: UINavigationController, signOut: VoidClouser?) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let router = ProfileRouter(navigationController: navigationController)
        let presenter = ProfilePresenter(router: router, requestFactory: requestFactory, signOut: signOut)
        let controller = ProfileViewController(presenter: presenter)
        presenter.viewInput = controller
        return controller
    }
    
    static func catalogBuild(navigationController: UINavigationController) -> UIViewController {
        let router = HomeRouter(navigationController: navigationController)
        let controller = CatalogViewController()
        controller.presenter = CatalogPresenter(router: router)
        return controller
    }
    
    static func productBuild(navigationController: UINavigationController) -> UIViewController {
        let controller = ProductViewController()
        return controller
    }
    
    static func noConnectionBuild(completion: @escaping VoidClouser) -> UIViewController {
        let controller = NoConnectionViewController()
        controller.connectionWasRestored = completion
        return controller
    }
}
