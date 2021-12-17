//
//  UserRequestsTests.swift
//  ShopTests
//
//  Created by Ilya on 08.12.2021.
//

import XCTest
@testable import Shop

class UserRequestsTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://secret-everglades-22465.herokuapp.com/")
    
    var userRequest: UserRequestFactory!
    
    override func setUpWithError() throws {
        userRequest = RequestFactory().makeUserRequestFactory()
    }
    
    override func tearDownWithError() throws {
        userRequest = nil
    }
    
    func testRegister() {
        
        let expressionRegisterUserResultStub = RegisterUserResult(result: 1,
                                                                  userMessage: "Регистрация прошла успешно!")
        let profile = generateProfile()
        
        userRequest.register(for: profile) { response in
            switch response.result {
            case .success(let register):
                XCTAssertEqual(register.result, expressionRegisterUserResultStub.result)
                XCTAssertEqual(register.userMessage, expressionRegisterUserResultStub.userMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testChange() {
        
        let profile = generateProfile()
        
        let expressionChangeUserDataResultStub = ChangeUserDataResult(result: 1,
                                                                      userMessage: "Данные успешно изменены")
        
        userRequest.change(for: profile) { response in
            switch response.result {
            case .success(let change):
                XCTAssertEqual(change.result, expressionChangeUserDataResultStub.result)
                XCTAssertEqual(change.userMessage, expressionChangeUserDataResultStub.userMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func generateProfile() -> ProfileResult {
        ProfileResult(userId: 123,
                login: "Somebody",
                password: "mypassword",
                email: "some@some.ru",
                gender: "m",
                creditCard: "9872389-2424-234224-234",
                bio: "This is good! I think I will switch to another language")
    }
    
}
