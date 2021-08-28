//
//  IntroViewControllerUITests.swift
//  MungMungLogDevUITests
//
//  Created by JunHee Jo on 2021/08/28.
//

import XCTest

class IntroViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    // TODO: - KeyChain 여부에 따른 View이동을 UITest에서 구현할 수 있을까??
}
