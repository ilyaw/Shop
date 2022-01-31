//
//  Home.swift
//  Shop
//
//  Created by Ilya on 20.01.2022.
//

import Foundation
import Alamofire

class Home: BaseStoreRequest {
    private struct HomeRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getHomeData"
        
        var parameters: Parameters?
    }
}

// MARK: - Home + HomeRequestFactory

extension Home: HomeRequestFactory {
    func getHomeData(completionHandler: @escaping (AFDataResponse<HomeResult>) -> Void) {
        let homeRequest = HomeRequest(baseUrl: url)
        self.request(request: homeRequest, completionHandler: completionHandler)
    }
}
