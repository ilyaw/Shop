//
//  FeedbackRequestFactory.swift
//  Shop
//
//  Created by Ilya on 17.12.2021.
//

import Foundation
import Alamofire

protocol FeedbackRequestFactory {
    func getFeedback(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<FeedbackResult>) -> Void
    )
    
    func addFeedback(
        text: String,
        userId: Int,
        productId: Int,
        completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void
    )
    
    func removeFeedback(
        feedbackId: Int,
        userId: Int,
        completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void
    )
}
