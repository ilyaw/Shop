//
//  UserDefaultsStorage.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage {
    private let key: String
    private let defaultValue: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: String {
        get {
            return UserDefaults.standard.string(forKey: key) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
