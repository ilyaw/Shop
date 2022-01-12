//
//  NoConnectionBuilder.swift
//  Shop
//
//  Created by Ilya on 03.01.2022.
//

import UIKit

class NoConnectionBuilder {
    static func build(completion: @escaping VoidClouser) -> UIViewController {
        let viewController = NoConnectionViewController()
        viewController.connectionWasRestored = completion
        return viewController
    }
}
