//
//  UserResult.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation

struct UserResult: Codable {
    let id: Int
    let login: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case firstName = "firstName"
        case lastName = "lastName"
    }
}
