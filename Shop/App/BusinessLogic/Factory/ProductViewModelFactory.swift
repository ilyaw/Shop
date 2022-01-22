//
//  ProductViewModelFactory.swift
//  Shop
//
//  Created by Ilya on 22.01.2022.
//

import Foundation

struct ProductViewModel {
    let url: URL?
    let productName: String
    let price: String
    let oldPrice: String?
}

final class ProductViewModelFactory {
    
    func constuctViewModels(products: [Product]) -> [ProductViewModel] {
        return products.map(viewModel)
    }
    
    private func viewModel(from product: Product) -> ProductViewModel {
        let url = URL(string: product.photo)
        let productName = product.name
        let price = "\(product.price) ₽"
        var oldPrice: String?
        
        if let discount = product.discount {
            let price = (product.price / 100) * (100 + discount)
            oldPrice = "\(price)"
        }
        
        return ProductViewModel(url: url,
                                productName: productName,
                                price: price,
                                oldPrice: oldPrice)
    }
}
