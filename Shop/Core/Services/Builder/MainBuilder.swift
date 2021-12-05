//
//  MainBulider.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

class MainBuilder {
    static func build() -> (UIViewController & MainViewInput) {
        let presenter = MainPresenter()
        let requestFactory = RequestFactory()
        let viewController = MainViewController(presenter: presenter,
                                                requestFactory: requestFactory)
        presenter.viewInput = viewController
        
        return viewController
    }
}
