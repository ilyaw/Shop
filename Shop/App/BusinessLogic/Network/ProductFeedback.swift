//
//  ProductFeedback.swift
//  Shop
//
//  Created by Ilya on 17.12.2021.
//

import Foundation
import Alamofire

class ProductFeedback: BaseStoreRequest {
    private struct GetFeedbackRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getFeedback"
        
        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId,
            ]
        }
    }
    
    private struct AddFeedbackRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addFeedback"
        
        let text: String
        let userId: Int
        let productId: Int
        var parameters: Parameters? {
            return [
                "text": text,
                "userId": userId,
                "productId": productId,
            ]
        }
    }
    
    private struct RemoveFeedbackRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeFeedback"
        
        let feedbackId: Int
        let userId: Int
        var parameters: Parameters? {
            return [
                "feedbackId": feedbackId,
                "userId": userId,
            ]
        }
    }
}

// MARK: - ProductFeedback + FeedbackRequestFactory

extension ProductFeedback: FeedbackRequestFactory {
    func getFeedback(productId: Int,
                     completionHandler: @escaping (AFDataResponse<FeedbackResult>) -> Void) {
        let getFeedbackRequest = GetFeedbackRequest(baseUrl: url, productId: 123)
        self.request(request: getFeedbackRequest, completionHandler: completionHandler)
    }
    
    func addFeedback(text: String,
                     userId: Int,
                     productId: Int,
                     completionHandler: @escaping (AFDataResponse<FeedbackResult>) -> Void) {
        let addFeedbackRequest = AddFeedbackRequest(baseUrl: url,
                                                    text: text,
                                                    userId: userId,
                                                    productId: productId)
        self.request(request: addFeedbackRequest, completionHandler: completionHandler)
    }
    
    func removeFeedback(feedbackId: Int,
                        userId: Int,
                        completionHandler: @escaping (AFDataResponse<FeedbackResult>) -> Void) {
        let removeFeedbackRequest = RemoveFeedbackRequest(baseUrl: url,
                                                          feedbackId: feedbackId,
                                                          userId: userId)
        self.request(request: removeFeedbackRequest, completionHandler: completionHandler)
    }
}
