//
//  MonthChangerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/10.
//

import XCTest
@testable import MungMungLog

class MonthChangerTests: XCTestCase {
    var sut: MonthChanger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MonthChanger()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_calendar_whenInit_shouldCurrentCalendar() {
        XCTAssertEqual(Calendar.current, sut.calendar)
    }
    
    func test_calendarTimeZone_whenInit_shouldCurrentTimezone() {
        XCTAssertEqual(TimeZone.current, sut.calendar.timeZone)
    }
    
    func test_plusOneMonth_whenCalled_shouldPlusOneMonth() {
        let calendar: Calendar = sut.calendar
        let beforeDate: Date = Date()
        let beforeMonth: Int = calendar.dateComponents([.month], from: beforeDate).month!
        
        let afterDate: Date = sut.plusOneMonth(date: beforeDate)
        let afterMonth: Int = calendar.dateComponents([.month], from: afterDate).month!
        
        XCTAssertEqual(beforeMonth + 1, afterMonth)
    }
    
    func test_plusOneMonth_whenFailedBinding_shouldReturnCurrentDate() {
        
    }
    
    func test_minusOneMonth_whenFailedBinding_shouldReturnCurrentDate() {
        
    }
    
    func test_minusOneMonth_whenCalled_shouldMinusOneMonth() {
        let calendar: Calendar = sut.calendar
        let beforeDate: Date = Date()
        let beforeMonth: Int = calendar.dateComponents([.month], from: beforeDate).month!
        
        let afterDate: Date  = sut.minusOneMonth(date: beforeDate)
        let afterMonth: Int = calendar.dateComponents([.month], from: afterDate).month!
        
        XCTAssertEqual(beforeMonth - 1, afterMonth)
    }
    
}
