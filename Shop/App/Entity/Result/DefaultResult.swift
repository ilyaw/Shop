//
//  RegisterUser.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation

struct DefaultResult: Codable {
    let result: Int
    var userMessage: String? = nil
    var errorMessage: String? = nil
}
