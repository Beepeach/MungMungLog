//
//  LoginViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/08/01.
//

import XCTest
@testable import MungMungLog

class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
