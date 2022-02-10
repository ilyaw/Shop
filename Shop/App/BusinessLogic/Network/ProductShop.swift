//
//  ProductShop.swift
//  Shop
//
//  Created by Ilya on 08.12.2021.
//

import Foundation
import Alamofire

class ProductShop: BaseStoreRequest {
    private struct CatalogRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalog"
        
        let numberPage: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "pageNumber": numberPage,
                "categoryId": categoryId
            ]
        }
    }
    
    private struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "product"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
}

// MARK: ProductRequestFactory

extension ProductShop: ProductRequestFactory {
    func getCatalog(numberPage: Int,
                    categoryId: Int,
                    completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void) {
        let catalogDataRequest = CatalogRequest(baseUrl: url, numberPage: numberPage, categoryId: categoryId)
        self.request(request: catalogDataRequest, completionHandler: completionHandler)
    }
    
    func getProductById(productId: Int,
                        completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let getProductRequest = ProductRequest(baseUrl: url, productId: productId)
        self.request(request: getProductRequest, completionHandler: completionHandler)
    }
}
