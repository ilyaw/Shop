//
//  ProfileResult.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation

struct ProfileResult: Codable {
    let login: String
    let password: String
    let firstName: String
    let lastName: String
    let gender: String
    var bio: String?
    var creditCard: String?
    var money: Decimal? = 5000000
}
