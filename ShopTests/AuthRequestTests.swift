//
//  AuthRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 08.12.2021.
//

import XCTest
@testable import Shop

class AuthRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    var authRequest: AuthRequestFactory!
    
    override func setUpWithError() throws {
        authRequest = RequestFactory().makeAuthRequestFatory()
    }
    
    override func tearDownWithError() throws {
        authRequest = nil
    }
    
    func testAuth() throws {
        
        let expressionLoginResultStub = LoginResult(result: 1,
                                                    user: User(id: 123,
                                                               login: "geekbrains",
                                                               name: "John",
                                                               lastname: "Doe"))
        
        authRequest.login(userName: "Somebody", password: "mypassword") { (response) in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.result, expressionLoginResultStub.result)
                XCTAssertEqual(login.user.id, expressionLoginResultStub.user.id)
                XCTAssertEqual(login.user.login, expressionLoginResultStub.user.login)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogout() throws {
        
        let expressionLogoutResultStub = LogoutResult(result: 1)
        
        authRequest.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.result, expressionLogoutResultStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
