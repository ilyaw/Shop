//
//  AuthBuilder.swift
//  Shop
//
//  Created by Ilya on 03.01.2022.
//

import UIKit

class AuthBuilder {
    static func build() -> (UIViewController & AuthViewInput) {
        let presenter = AuthPresenter()
        let requestFactory = RequestFactory()
        let viewController = AuthViewController(presenter: presenter,
                                                requestFactory: requestFactory)
        presenter.viewInput = viewController
        
        return viewController
    }
}
