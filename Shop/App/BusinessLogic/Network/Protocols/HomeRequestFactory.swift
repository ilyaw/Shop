//
//  HomeRequestFactory.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import Foundation
import Alamofire

protocol HomeRequestFactory {
    func getHomeData(completionHandler: @escaping (AFDataResponse<HomeResult>) -> Void)
}
