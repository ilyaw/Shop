//
//  HomeViewController.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"        
        view.backgroundColor = .systemBackground
    }
    
    deinit {
        print("deinit HomeViewController")
    }
}
