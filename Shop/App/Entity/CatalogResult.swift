//
//  CatalogResult.swift
//  Shop
//
//  Created by Ilya on 08.12.2021.
//

import Foundation

struct CatalogResult: Codable {
    struct Product: Codable {
        let productId: Int
        let productName: String
        let price: Int

        enum CodingKeys: String, CodingKey {
            case productId = "id_product"
            case productName = "product_name"
            case price
        }
    }
}
