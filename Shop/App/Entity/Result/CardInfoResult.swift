//
//  CardInfoResult.swift
//  Shop
//
//  Created by Ilya on 14.01.2022.
//

import Foundation

struct CardInfoResult: Codable {
    struct Card: Codable {
        var creditCard: String
        var money: Decimal
    }
    
    let result: Int
    let card: Card?
}
