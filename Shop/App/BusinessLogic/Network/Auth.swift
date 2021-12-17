//
//  Auth.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation
import Alamofire

class Auth: BaseStoreRequest {
    private struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    private struct Logout: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "logout"
        
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
}

// MARK: AuthRequestFactory

extension Auth: AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: url, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: url, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
