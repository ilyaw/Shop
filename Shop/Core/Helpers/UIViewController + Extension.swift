//
//  UIViewController + Extension.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Ok",
                                      message: "\(message)!",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
