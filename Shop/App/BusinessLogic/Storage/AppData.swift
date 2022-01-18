//
//  AppData.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import Foundation

struct AppData {
    @UserDefaultsStorage<String>(key: AppConstant.firstNameKey, defaultValue: "")
    static var fullName: String
    
    @UserDefaultsStorage<Bool>(key: AppConstant.isActivePushNotification, defaultValue: false)
    static var isAcitvePushNotification: Bool
    
    @KeychainStorage(key: AppConstant.keychainAccessTokenKey, defaultValue: "")
    static var accessToken: String
}
