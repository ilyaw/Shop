//
//  CatalogPresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import Foundation

// MARK: - Presenter

protocol CatalogPresenterInput: AnyObject {
    
}

protocol CatalogPresenterOutput: AnyObject {
    init(router: HomeRouter)
    func openProduct(by id: Int)
}

class CatalogPresenter: CatalogPresenterOutput {
    
    weak var input: CatalogPresenterInput?
    private let router: HomeRouter
    
    required init(router: HomeRouter) {
        self.router = router
    }
    
    func openProduct(by id: Int) {
        router.showDetailProduct(by: id)
    }
    
    deinit {
        print("deinit CatalogPresenter")
    }
}
