//
//  UserRequestFactory.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation
import Alamofire

protocol UserRequestFactory {
    func register(for user: ProfileResult, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func change(for user: UpdateUser, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    func getCardInfo(accessToken: String, completionHandler: @escaping (AFDataResponse<CardInfoResult>) -> Void)
    func getUserInfo(accessToken: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void)
}
