//
//  UserRequestFactory.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation
import Alamofire

protocol UserRequestFactory {
    func register(for user: User, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    func change(for user: User, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
