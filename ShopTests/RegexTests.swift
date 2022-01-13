//
//  RegexTests.swift
//  ShopTests
//
//  Created by Ilya on 13.01.2022.
//

import XCTest
@testable import Shop

class RegexTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testLogin() throws {
        let validLogin = "FooBar"
        XCTAssertTrue(validLogin.isValid(validType: .login))
        
        let invalidLogin = "1123"
        XCTAssertFalse(invalidLogin.isValid(validType: .login))
    }
    
    func testName() throws {
        let validName = "Foo Bar"
        XCTAssertTrue(validName.isValid(validType: .name))
        
        let invalidName = "Foo Bar2"
        XCTAssertFalse(invalidName.isValid(validType: .name))
    }
    
    func testEmail() throws {
        let validEmail = "foobar@foobar.com"
        XCTAssertTrue(validEmail.isValid(validType: .email))
        
        let invalidEmail = "foobar@foobar"
        XCTAssertFalse(invalidEmail.isValid(validType: .email))
    }
    
    func testPhone() throws {
        let validPhone = "+79999999999"
        XCTAssertTrue(validPhone.isValid(validType: .phone))
        
        let invalidPhone = "7911684006"
        XCTAssertFalse(invalidPhone.isValid(validType: .phone))
        
        let invalidPhone2 = "м7911684006"
        XCTAssertFalse(invalidPhone2.isValid(validType: .phone))
    }
    
    func testPassword() throws {
        let validPassword = "1236534"
        XCTAssertTrue(validPassword.isValid(validType: .password))
        
        let validPassword2 = "foobar"
        XCTAssertTrue(validPassword2.isValid(validType: .password))
        
        let validPassword3 = "foobar123"
        XCTAssertTrue(validPassword3.isValid(validType: .password))
        
        let invalidPassword = "12"
        XCTAssertFalse(invalidPassword.isValid(validType: .password))
        
        let invalidPassword2 = "   "
        XCTAssertFalse(invalidPassword2.isValid(validType: .password))
    }
}
