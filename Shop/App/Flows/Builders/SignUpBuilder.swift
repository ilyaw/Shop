//
//  SignUpBuilder.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

class SignUpBuilder {
    static func build(router: StartRouter) -> UIViewController {
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let presenter = SignUpPresenter(router: router, requestFactory: requestFactory)
        let viewController = SignUpViewController(presenter: presenter)
        presenter.viewInput = viewController
        
        return viewController
    }
}
