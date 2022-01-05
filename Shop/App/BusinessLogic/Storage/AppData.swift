//
//  AppData.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import Foundation

struct AppData {
    @UserDefaultsStorage(key: AppConstant.firstNameKey, defaultValue: "")
    static var username: String
    
    @KeychainStorage(key: AppConstant.keychainAccessTokenKey, defaultValue: "")
    static var accessToken: String
}
