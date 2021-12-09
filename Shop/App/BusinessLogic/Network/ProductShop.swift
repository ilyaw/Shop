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
        let path: String = "catalogData.json"
        
        let numberPage: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number": numberPage,
                "id_category": categoryId
            ]
        }
    }
    
    private struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId,
            ]
        }
    }
}

// MARK: ProductRequestFactory

extension ProductShop: ProductRequestFactory {
    func getCatalog(numberPage: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogResult.Product]>) -> Void) {
        let catalogData = CatalogRequest(baseUrl: url, numberPage: numberPage, categoryId: categoryId)
        self.request(request: catalogData, completionHandler: completionHandler)
    }
    
    func getProductById(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let product = ProductRequest(baseUrl: url, productId: productId)
        self.request(request: product, completionHandler: completionHandler)
    }
}
