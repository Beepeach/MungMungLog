//
//  WalkRecordStartingVCUITests.swift
//  MungMungLogDevUITests
//
//  Created by JunHee Jo on 2021/05/12.
//

import XCTest
//@testable import MungMungLog

class WalkRecordStartingVCUITests: XCTestCase {

    var app: XCUIApplication!
    var tabBar: UITabBarController!

    override func setUpWithError() throws {

        app = XCUIApplication()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSomething() {

    }
}
