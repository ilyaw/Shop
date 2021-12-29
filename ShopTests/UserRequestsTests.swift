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
                

        var generateRandomName = String()
        
        for _ in 0...10 {
          let randomChar = Character(UnicodeScalar(Int.random(in: (65...85)))!)
            generateRandomName += String(randomChar)
        }
        
        let expressionRegisterUserResultStub = LoginResult(result: 1,
                                                           user: UserResult(id: -1,
                                                                            login: generateRandomName,
                                                                            firstName: "Foo",
                                                                            lastName: "Bar",
                                                                            accessToken: String()))
        
        let profile = ProfileResult(login: generateRandomName, password: "123456", firstName: "Foo", lastName: "Bar", gender: "m", bio: "dlfdsfsdf")
        
        userRequest.register(for: profile) { response in
            switch response.result {
            case .success(let register):
                XCTAssertEqual(register.result, expressionRegisterUserResultStub.result)
                XCTAssertEqual(register.user.login, expressionRegisterUserResultStub.user.login)
                XCTAssertEqual(register.user.firstName, expressionRegisterUserResultStub.user.firstName)
                XCTAssertEqual(register.user.lastName, expressionRegisterUserResultStub.user.lastName)
                XCTAssertFalse(register.user.accessToken.isEmpty)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
//    func testChange() {
//
//        let profile = generateProfile()
//
//        let expressionChangeUserDataResultStub = ChangeUserDataResult(result: 1,
//                                                                      userMessage: "Данные успешно изменены")
//
//        userRequest.change(for: profile) { response in
//            switch response.result {
//            case .success(let change):
//                XCTAssertEqual(change.result, expressionChangeUserDataResultStub.result)
//                XCTAssertEqual(change.userMessage, expressionChangeUserDataResultStub.userMessage)
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
