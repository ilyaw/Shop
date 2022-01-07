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
    let fullName: String
    let accessToken: String
}
