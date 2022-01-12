//
//  HomePresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import Foundation

// MARK: - Presenter

protocol HomePresenterInput: AnyObject { }

protocol HomePresenterOutput: AnyObject {
    init(router: HomeRouter)
    func detailProduct(by id: Int)
    func showCatalog()
}

class HomePresenter: HomePresenterOutput {
    
    weak var input: HomePresenterInput?
    private let router: HomeRouter
    
    required init(router: HomeRouter) {
        self.router = router
    }
    
    func detailProduct(by id: Int) {
        router.showDetailProduct(by: id)
    }
    
    func showCatalog() {
        router.showCatalog()
    }
}
