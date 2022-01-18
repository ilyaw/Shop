//
//  UpdateUser.swift
//  Shop
//
//  Created by Ilya on 18.01.2022.
//

import Foundation

struct UpdateUser: Encodable {
    let accessToken: String
    let name: String
    let phone: String
    let card: String
}
