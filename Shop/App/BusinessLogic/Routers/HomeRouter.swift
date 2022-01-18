//
//  HomeRouter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

// MARK: - Home Router

class HomeRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showCatalog() {
        let catalogController = Builders.catalogBuild(navigationController: navigationController)
        navigationController.pushViewController(catalogController, animated: true)
    }
    
    func showDetailProduct(by id: Int) {
        let productController = ProductViewController()
        productController.id = id
        navigationController.pushViewController(productController, animated: true)
    }
}
