//
//  Product.swift
//  Shop
//
//  Created by Ilya on 15.12.2021.
//

import Foundation

struct Product: Codable {
    let id: Int
    let photo: String
    let name: String
    let price: Decimal
    var description: String?
    var discount: Decimal?
}
