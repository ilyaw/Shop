//
//  ProfileResult.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation

struct ProfileResult: Codable {
    let userId: Int
    let login: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case login = "userName"
        case password = "password"
        case email = "email"
        case gender = "gender"
        case creditCard = "creditCard"
        case bio = "bio"
    }
}
