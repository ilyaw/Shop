//
//  ProfileUser.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation
import Alamofire

class ProfileUser: BaseStoreRequest {
    private struct UserRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String
        
        let profile: ProfileResult
        
        var parameters: Parameters? {
            return [
                "login": profile.login,
                "password": profile.password,
                "fullName": profile.fullName,
                "phone": profile.phone,
                "bio": profile.bio ?? "",
                "creditCard": profile.creditCard ?? ""
            ]
        }
    }
    
    private struct ChangeUserRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "change"
        
        let user: UpdateUser
        
        var parameters: Parameters? {
            return [
                "accessToken": user.accessToken,
                "name": user.name,
                "phone": user.phone,
                "card": user.card
            ]
        }
    }
    
    private struct GetInfoRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String

        let accessToken: String

        var parameters: Parameters? {
            return [
                "accessToken": accessToken
            ]
        }
    }
}

// MARK: - ProfileUser + UserRequestFactory

extension ProfileUser: UserRequestFactory {

    func register(for user: ProfileResult, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let registerRequest = UserRequest(baseUrl: url, path: "register", profile: user)
        self.request(request: registerRequest, completionHandler: completionHandler)
    }

    func change(for user: UpdateUser, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let changeRequest = ChangeUserRequest(baseUrl: url, user: user)
        self.request(request: changeRequest, completionHandler: completionHandler)
    }
    
    func getCardInfo(accessToken: String, completionHandler: @escaping (AFDataResponse<CardInfoResult>) -> Void) {
        let cardInfoRequst = GetInfoRequest(baseUrl: url, path: "getCardInfo", accessToken: accessToken)
        self.request(request: cardInfoRequst, completionHandler: completionHandler)
    }

    func getUserInfo(accessToken: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void) {
        let userInfoRequst = GetInfoRequest(baseUrl: url, path: "getUserInfo", accessToken: accessToken)
        self.request(request: userInfoRequst, completionHandler: completionHandler)
    }
}
