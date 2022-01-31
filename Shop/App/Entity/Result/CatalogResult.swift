//
//  CatalogResult.swift
//  Shop
//
//  Created by Ilya on 08.12.2021.
//

import Foundation

struct CatalogResult: Codable {
    let result: Int
    let products: [Product]
    let isNextPage: Bool
    let isPreviousPage: Bool
}
