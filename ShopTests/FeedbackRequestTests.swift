//
//  FeedbackRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 17.12.2021.
//

import XCTest
@testable import Shop

class FeedbackRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://secret-everglades-22465.herokuapp.com/")
    
    var feedbackRequest: FeedbackRequestFactory!
    
    override func setUpWithError() throws {
        feedbackRequest = RequestFactory().makeFeedbackRequestFactory()
    }
    
    override func tearDownWithError() throws {
        feedbackRequest = nil
    }
    
    func testGetFeedback() {
        
    }
    
}
