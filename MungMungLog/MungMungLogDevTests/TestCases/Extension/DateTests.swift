//
//  DateTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/11.
//

import XCTest
@testable import MungMungLog

class DateTests: XCTestCase {
    var sut: Date!

    override func setUpWithError() throws {
        try super.tearDownWithError()
        sut = {
            var dateComponents: DateComponents = DateComponents()
            dateComponents.timeZone = TimeZone.current
            dateComponents.year = 2021
            dateComponents.month = 07
            dateComponents.day = 10
            
            let date: Date = Calendar.current.date(from: dateComponents)!
            
            return date
        }()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_yearFormatter_shouldReturnYearString() {
        let year: String = sut.yearFormatted
        
        XCTAssertEqual("2021년", year)
    }
    
    func test_monthFormatter_shouldReturnMonthString() {
        let month: String = sut.monthFormatted
        
        XCTAssertEqual("07월", month)
    }
    
    func test_koreanDateFormatter_shouldRetrunKoreanDateString() {
        let date: String = sut.koreanDateFormatted
        
        XCTAssertEqual("2021년 07월 10일", date)
    }
}
