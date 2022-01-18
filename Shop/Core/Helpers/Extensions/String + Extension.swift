//
//  String + Extension.swift
//  Shop
//
//  Created by Ilya on 07.01.2022.
//

import Foundation

extension String {
    
    enum ValidTypes {
        case login
        case name
        case email
        case phone
        case card
        case password
    }
    
    enum Regex: String {
        case login = "[a-zA-Z]{2,}"
        case name = "[a-zA-Zа-яА-Я\\s]{2,}"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
        case phone = "\\+\\d\\s\\(\\d{3}\\)\\s\\d{3}-\\d{2}-\\d{2}"
        case card = "\\d{4}-\\d{4}-\\d{4}-\\d{4}"
        case password = "\\w.{5,}" // "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .login: regex = Regex.login.rawValue
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .phone: regex = Regex.phone.rawValue
        case .card: regex = Regex.card.rawValue
        case .password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
