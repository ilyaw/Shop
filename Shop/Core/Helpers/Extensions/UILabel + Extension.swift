//
//  UILabel + Extension.swift
//  Shop
//
//  Created by Ilya on 05.01.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
