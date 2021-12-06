//
//  ProfileUser.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation
import Alamofire

class ProfileUser: StoreBaseURL, AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

// MARK: UserRequestFactory

extension ProfileUser: UserRequestFactory {
    func register(for user: Profile, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let registerRequest = UserRequest(baseUrl: url, path: "registerUser.json", profile: user)
        self.request(request: registerRequest, completionHandler: completionHandler)
    }
    
    func change(for user: Profile, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let changeRequest = UserRequest(baseUrl: url, path: "changeUserData.json", profile: user)
        self.request(request: changeRequest, completionHandler: completionHandler)
    }
}

extension ProfileUser {
    struct UserRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        
        let profile: Profile
        
        var parameters: Parameters? {
            return [
                "username": profile.login,
                "password": profile.password,
                "id_user": profile.userId,
                "email": profile.email,
                "gender": profile.gender,
                "credit_card": profile.creditCard,
                "bio": profile.bio
            ]
        }
    }
}
