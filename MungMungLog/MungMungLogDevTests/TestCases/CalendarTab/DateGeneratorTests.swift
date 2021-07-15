//
//  DateGeneratorTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/15.
//

import XCTest
@testable import MungMungLog

class DateGeneratorTests: XCTestCase {
    var sut: DateGenerator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DateGenerator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_create_shouldCreateCollectDate() {
        let date: Date = Date(timeIntervalSinceReferenceDate: 0)
        
        XCTAssertEqual(date, sut.create(year: 2001, month: 1, day: 1))
    }
}
