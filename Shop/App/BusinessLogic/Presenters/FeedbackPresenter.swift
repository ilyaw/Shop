//
//  FeedbackPresenter.swift
//  Shop
//
//  Created by Ilya on 01.02.2022.
//

import Foundation

protocol FeedbackPresenterInput: AnyObject {
    var feedbackView: FeedbackView { get }
}

protocol FeedbackPresenterOutput: AnyObject {
    init(productRequest: ProductRequestFactory, productId: Int)
    func fetchData()
}

class FeedbackPresenter {

    // MARK: - Public properties
    
    weak var input: FeedbackPresenterInput?
    
    // MARK: - Private properties
    
    private let feedbackRequest: FeedbackRequestFactory
    private let productId: Int
    
    // MARK: - Inits
    
    required init(feedbackRequest: FeedbackRequestFactory, productId: Int) {
        self.feedbackRequest = feedbackRequest
        self.productId = productId
    }
}
