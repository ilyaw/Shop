//
//  ProductViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class ProductViewController: UIViewController {

    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Product id = \(id ?? -1)"
        view.backgroundColor = .systemBackground
    }
}
