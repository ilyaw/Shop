//
//  UserInfoResult.swift
//  Shop
//
//  Created by Ilya on 17.01.2022.
//

import Foundation

protocol UserInfo {
    var name: String { get }
    var phone: String { get }
    var card: String? { get }
}

struct UserInfoResult: Codable {
    struct User: Codable, UserInfo {
        var name: String
        var phone: String
        var card: String?
    }
    
    let result: Int
    let user: User?
}
