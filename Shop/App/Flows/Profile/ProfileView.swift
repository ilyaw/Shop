//
//  ProfileView.swift
//  Shop
//
//  Created by Ilya on 14.01.2022.
//

import UIKit

class ProfileView: UIView {
 
    init() {
        super.init(frame: .zero)
        
        let label = UILabel(text: AppData.fullName)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
