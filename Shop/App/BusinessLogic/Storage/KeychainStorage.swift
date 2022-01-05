//
//  KeychainStorage.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import Foundation
import SwiftKeychainWrapper

@propertyWrapper
struct KeychainStorage {
    private let key: String
    private let defaultValue: String
    
    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: String {
        get {
            return KeychainWrapper.standard.string(forKey: key) ?? defaultValue
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: key)
        }
    }
}
