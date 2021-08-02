//
//  AlertCreatorTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/08/01.
//

import XCTest
@testable import MungMungLog

class AlertCreatorTests: XCTestCase {
    var sut: AlertCreator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AlertCreator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
