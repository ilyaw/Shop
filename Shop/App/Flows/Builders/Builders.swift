//
//  Builders.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class Builders {
    
    static func loadScreenBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeAuthRequestFatory()
        let presenter = LoaderScreenPresenter(router: router, requestFactory: requestFactory)
        let controller = LoaderScreenViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func authBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeAuthRequestFatory()
        let presenter = AuthPresenter(router: router, requestFactory: requestFactory)
        let controller = AuthViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func signUpBuild(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let presenter = SignUpPresenter(router: router, requestFactory: requestFactory)
        let controller = SignUpViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func homeBuild(navigationController: UINavigationController) -> UIViewController {
        let requestFactory = RequestFactory().makeHomeRequestFactory()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(router: router, requestFactory: requestFactory)
        let controller = HomeViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func cartBuild(navigationController: UINavigationController) -> UIViewController {
        let controller = CartViewController()
        return controller
    }
    
    static func profileBuild(navigationController: UINavigationController, signOut: VoidClouser?) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let router = ProfileRouter(navigationController: navigationController, signOut: signOut)
        let presenter = ProfilePresenter(router: router, requestFactory: requestFactory, signOut: signOut)
        let controller = ProfileViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func settingsBuild(signOut: VoidClouser?) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let presenter = SettingsPresenter(requestFactory: requestFactory, signOut: signOut)
        let controller = SettingsViewController(presenter: presenter)
        presenter.input = controller
        
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
    
    static func catalogBuild(navigationController: UINavigationController, catalogId: Int) -> UIViewController {
        let requestFactory = RequestFactory().makeProductRequestFactory()
        let router = HomeRouter(navigationController: navigationController)
        let presenter = CatalogPresenter(router: router, requestFactory: requestFactory, catalogId: catalogId)
        let controller = CatalogViewController(presenter: presenter)
        presenter.input = controller
        return controller
    }
    
    static func productBuild(navigationController: UINavigationController) -> UIViewController {
        let controller = ProductViewController()
        return controller
    }
}
