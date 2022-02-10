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

    func showProducts(by categoryId: Int, title: String) {
        let catalogController = Builders.catalogBuild(navigationController: navigationController,
                                                      catalogId: categoryId)
        catalogController.navigationItem.title = title
        catalogController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(catalogController, animated: true)
    }
    
    func showDetailProduct(by productId: Int) {
        let productController = ProductViewController()
        productController.id = productId
        navigationController.pushViewController(productController, animated: true)
    }
}
