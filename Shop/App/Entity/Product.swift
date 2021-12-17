//
//  Product.swift
//  Shop
//
//  Created by Ilya on 15.12.2021.
//

import Foundation

struct Product: Codable {
    let productId: Int
    let productName: String
    let productPrice: Int
    var productDescription: String? = nil
}
