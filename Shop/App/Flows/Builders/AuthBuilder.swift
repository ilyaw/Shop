//
//  AuthBuilder.swift
//  Shop
//
//  Created by Ilya on 03.01.2022.
//

import UIKit

class AuthBuilder {
    static func build() -> UIViewController {
        let navigation = UINavigationController()
        let presenter = AuthPresenter()
        let requestFactory = RequestFactory().makeAuthRequestFatory()
        let viewController = AuthViewController(presenter: presenter,
                                                requestFactory: requestFactory)
        presenter.viewInput = viewController
        
        navigation.viewControllers = [viewController]
        return navigation
    }
}
