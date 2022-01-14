//
//  ViewSpecificController.swift
//  Shop
//
//  Created by Ilya on 14.01.2022.
//

import UIKit

protocol ViewSpecificController {
    associatedtype RootView: UIView
}

extension ViewSpecificController where Self: UIViewController {
    func view() -> RootView? {
        return self.view as? RootView
    }
}
