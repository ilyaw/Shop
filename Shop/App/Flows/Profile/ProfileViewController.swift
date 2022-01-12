//
//  ProfileViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenterOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        view.backgroundColor = .orange
        
        presenter?.didTapSignOut()
    }
}
