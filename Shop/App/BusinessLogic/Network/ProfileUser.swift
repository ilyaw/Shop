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
    
    private struct CardInfoRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "getCardInfo"

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
    
    func change(for user: ProfileResult, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let changeRequest = UserRequest(baseUrl: url, path: "change", profile: user)
        self.request(request: changeRequest, completionHandler: completionHandler)
    }
    
    func getCardInfo(accessToken: String, completionHandler: @escaping (AFDataResponse<CardInfoResponse>) -> Void) {
        let cardInfoRequst = CardInfoRequest(baseUrl: url, accessToken: accessToken)
        self.request(request: cardInfoRequst, completionHandler: completionHandler)
    }
}
