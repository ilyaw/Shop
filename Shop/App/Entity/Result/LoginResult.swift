//
//  LoginResult.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    var errorMessage: String? = nil
    let user: UserResult
}
