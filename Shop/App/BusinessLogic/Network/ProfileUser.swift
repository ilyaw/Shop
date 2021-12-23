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
                "userName": profile.login,
                "password": profile.password,
                "userId": profile.userId,
                "email": profile.email,
                "gender": profile.gender,
                "creditCard": profile.creditCard,
                "bio": profile.bio
            ]
        }
    }
}

// MARK: UserRequestFactory

extension ProfileUser: UserRequestFactory {
    func register(for user: ProfileResult, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let registerRequest = UserRequest(baseUrl: url, path: "register", profile: user)
        self.request(request: registerRequest, completionHandler: completionHandler)
    }
    
    func change(for user: ProfileResult, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let changeRequest = UserRequest(baseUrl: url, path: "change", profile: user)
        self.request(request: changeRequest, completionHandler: completionHandler)
    }
}
