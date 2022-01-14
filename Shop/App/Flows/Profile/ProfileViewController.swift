//
//  ProfileViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class ProfileViewController: UIViewController, ViewSpecificController {
    typealias RootView = ProfileView
    
    // MARK: - Public properties
    
    var presenter: ProfilePresenterOutput?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        view.backgroundColor = .orange
        
        presenter?.didTapSignOut()
//        presenter?.getInfoCart()
    }
    
    override func loadView() {
        view = ProfileView()
    }
}
