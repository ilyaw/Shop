//
//  CatalogViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class CatalogViewController: UIViewController {

    var presenter: CatalogPresenterOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Catalog"
    }

}
