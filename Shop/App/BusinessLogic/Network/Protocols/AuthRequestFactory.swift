//
//  AuthRequestFactory.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func checkValidToken(accessToken: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
