//
//  LoginViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/04/30.
//

import XCTest
@testable import MungMungLog

class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
       sut = nil
    }
    
    func testInit_isAccessibleLoginIdIsFalse() {
        XCTAssertFalse(sut.isAccessibleLoginId)
    }
    
    func testInit_isAccessibleLoginPasswordIsFalse() {
        XCTAssertFalse(sut.isAccessibleLoginPassword)
    }
    
    
}
