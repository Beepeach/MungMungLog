//
//  LoginViewControllerUITests.swift
//  MungMungLogDevUITests
//
//  Created by JunHee Jo on 2021/08/03.
//

import XCTest

class LoginViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.setUpWithError()
    }
    
    func test_Alert_whenEmailNotExist_shouldPresentAlert() {
        let IdInputField: XCUIElement = app.textFields["IdInputField"]
        let passwordInputField: XCUIElement = app.secureTextFields["PasswordInputField"]
        let loginButton: XCUIElement = app.buttons["LoginButton"]
        
        IdInputField.tap()
        IdInputField.typeText("emailTest@test.com")
        passwordInputField.tap()
        passwordInputField.typeText("123456")
        loginButton.tap()
        
        let alert: XCUIElement = app.alerts["알림"]
        XCTAssertTrue(alert.waitForExistence(timeout: 1))
    }
}

