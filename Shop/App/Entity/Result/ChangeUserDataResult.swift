//
//  ChangeUserDataResult.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation

struct ChangeUserDataResult: Codable {
    let result: Int
    let userMessage: String
    var errorMessage: String?
}
