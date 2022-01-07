//
//  SignUpBuilder.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

class SignUpBuilder {
    static func build() -> UIViewController {
        let presenter = SignUpPresenter()
        let requestFactory = RequestFactory().makeUserRequestFactory()
        let viewController = SignUpViewController(presenter: presenter,
                                                requestFactory: requestFactory)
        presenter.viewInput = viewController
        
        return viewController
    }
}
