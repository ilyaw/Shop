//
//  FeedbackRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 17.12.2021.
//

import XCTest
@testable import Shop
import Alamofire

class FeedbackRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://secret-everglades-22465.herokuapp.com/")
    
    var feedbackRequest: FeedbackRequestFactory!
    
    override func setUpWithError() throws {
        feedbackRequest = RequestFactory().makeFeedbackRequestFactory()
    }
    
    override func tearDownWithError() throws {
        feedbackRequest = nil
    }
    
//    func test01AddFeedback() {
//        let expressionDefaultResultStub = DefaultResult(result: 1, userMessage: "Отзыв успешно отправлен!")
//        
//        feedbackRequest.addFeedback(text: "Nice product", userId: 1, productId: 123) { response in
//            switch response.result {
//            case .success(let response):
//                XCTAssertEqual(response.result, expressionDefaultResultStub.result)
//                XCTAssertEqual(response.userMessage, expressionDefaultResultStub.userMessage)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//    
//    func test02AddEmptyFeedback() {
//        let expressionDefaultResultStub = DefaultResult(result: 0, errorMessage: "Введите текст отзыва")
//        
//        feedbackRequest.addFeedback(text: "", userId: 1, productId: 123) { response in
//            switch response.result {
//            case .success(let response):
//                XCTAssertEqual(response.result, expressionDefaultResultStub.result)
//                XCTAssertEqual(response.userMessage, expressionDefaultResultStub.userMessage)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//    
//    func test03AddFeedbackForNonExistentProductId() {
//        feedbackRequest.addFeedback(text: "Good product", userId: 1, productId: -999999) { response in
//            switch response.result {
//            case .success( _):
//                XCTFail()
//            case .failure( _):
//                let statusCode = response.response?.statusCode
//                XCTAssertNotNil(statusCode)
//                XCTAssertEqual(statusCode!, 404)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//    
//    
//    
//    func test04GetFeedback() {
//        let resultStub = 1
//        
//        feedbackRequest.getFeedback(productId: 123) { response in
//            switch response.result {
//            case .success(let feedback):
//                XCTAssertLessThanOrEqual(feedback.result, resultStub)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//    
//    func test05RemoveFeedback() {
//        
//        let expressionDefaultResultStub = DefaultResult(result: 1, userMessage: "Ваш отзыв удален")
//        
//        feedbackRequest.getFeedback(productId: 123) { response in
//            switch response.result {
//            case .success(let feedback):
//                var feedbackId = feedback.feedback.first?.feedbackId
//                
//                XCTAssertNotNil(feedbackId)
//                feedbackId = feedbackId ?? 1
//                
//                self.feedbackRequest.removeFeedback(feedbackId: feedbackId!, userId: 1) { response in
//                    switch response.result {
//                    case .success(let result):
//                        XCTAssertEqual(result.result, expressionDefaultResultStub.result)
//                        XCTAssertEqual(result.userMessage, expressionDefaultResultStub.userMessage)
//                        XCTAssertNil(result.errorMessage)
//                    case .failure(let error):
//                        XCTFail(error.localizedDescription)
//                    }
//                    
//                    self.expectation.fulfill()
//                }
//                
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
}

