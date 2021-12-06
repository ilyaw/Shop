//
//  StoreURL.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation


protocol StoreBaseURL {
    var url: URL { get }
}

extension StoreBaseURL {
    var url: URL {
        URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    }
}
