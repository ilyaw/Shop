//
//  HomeResult.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import Foundation

protocol CategoryInfoProtocol {
    var categoryId: Int { get }
    var title: String { get }
    var icon: String { get }
}

struct HomeResult: Decodable {
    struct Category: Decodable, CategoryInfoProtocol {
        var categoryId: Int
        var title: String
        var icon: String
    }
    
    var adsBanners: [String]
    var categores: [Category]
}
