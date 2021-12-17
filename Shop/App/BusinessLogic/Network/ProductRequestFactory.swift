//
//  ProductRequestFactory.swift
//  Shop
//
//  Created by Ilya on 08.12.2021.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getCatalog(numberPage: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogResult.Product]>) -> Void)
    func getProductById(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
