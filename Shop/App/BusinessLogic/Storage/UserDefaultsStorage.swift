//
//  UserDefaultsStorage.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let value =  UserDefaults.standard.object(forKey: key) as? T else { return defaultValue }
            return value
//            return UserDefaults.standard.object(forKey: key) as? T
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
