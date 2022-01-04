//
//  UIApplication + Extension.swift
//  Shop
//
//  Created by Ilya on 04.01.2022.
//

import UIKit

extension UIApplication {
    static func setRootVC(viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
