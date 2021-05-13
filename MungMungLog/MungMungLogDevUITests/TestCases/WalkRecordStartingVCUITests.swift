//
//  WalkRecordStartingVCUITests.swift
//  MungMungLogDevUITests
//
//  Created by JunHee Jo on 2021/05/12.
//

import XCTest

class WalkRecordStartingVCUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    //HomeVC에서 검사를 해야하나??
    func testViewController_whenTapTapbar_moveToWalkRecordSTartingViewController() {
        app.tabBars.buttons.element(boundBy: 1).tap()
        
//        let tabBar = app.tabBars["산책"].firstMatch
        let startingWalk = app.staticTexts["산책 시작"].firstMatch
        
        XCTAssertTrue(startingWalk.waitForExistence(timeout: 30))
    }
}
