//
//  ProductPresenter.swift
//  Shop
//
//  Created by Ilya on 24.01.2022.
//

import Foundation

protocol ProductPresenterInput: AnyObject {
    var productView: ProductDetailInfoView { get }
}

protocol ProductPresenterOutput: AnyObject {
    init(productRequest: ProductRequestFactory, productId: Int)
    func fetchData()
}

class ProductPresenter {

    // MARK: - Public properties
    
    weak var input: ProductPresenterInput?
    
    // MARK: - Private properties
    
    private let productRequest: ProductRequestFactory
    private let productId: Int

    // MARK: - Inits

    required init(productRequest: ProductRequestFactory, productId: Int) {
        self.productRequest = productRequest
        self.productId = productId
    }
}

// MARK: - ProductPresenter + ProductPresenterOutput

extension ProductPresenter: ProductPresenterOutput {
    
    func fetchData() {
        productRequest.getProductById(productId: productId) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let result):
                let product = result.product
                
                DispatchQueue.main.async {
                    self.setView(with: product)
                }
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
}

// MARK: - ProductPresenter + private extension

private extension ProductPresenter {
    var view: ProductDetailInfoView {
        return input?.productView ?? ProductDetailInfoView()
    }
    
    func setView(with product: Product) {
        view.productImageView.kf.setImage(with: URL(string: product.photo))
        view.productTitle.text = product.name
        view.productDesciption.text = product.description
        view.layoutIfNeeded()
    }
}
