//
//  AuthRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 08.12.2021.
//

import XCTest
@testable import Shop

class AuthRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://secret-everglades-22465.herokuapp.com/")
    
    var authRequest: AuthRequestFactory!
    
    override func setUpWithError() throws {
        authRequest = RequestFactory().makeAuthRequestFatory()
    }
    
    override func tearDownWithError() throws {
        authRequest = nil
    }
    
    func testAuth() throws {
        
        let expressionLoginResultStub = LoginResult(result: 1,
                                                    user: UserResult(id: 1,
                                                                     login: "1",
                                                                     fullName: "Илья Руденко",
                                                                     accessToken: "4689145A-2EB1-425C-8843-FACFBDDFF4F0"))
        
        authRequest.login(userName: "1", password: "1") { (response) in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.result, expressionLoginResultStub.result)
                XCTAssertEqual(login.user!.id, expressionLoginResultStub.user!.id)
                XCTAssertEqual(login.user!.login, expressionLoginResultStub.user!.login)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
//    func testLogout() throws {
//
//        let expressionLogoutResultStub = LogoutResult(result: 1)
//
//        authRequest.logout(userId: 123) { response in
//            switch response.result {
//            case .success(let logout):
//                XCTAssertEqual(logout.result, expressionLogoutResultStub.result)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//
//            self.expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 10.0)
//    }
}
