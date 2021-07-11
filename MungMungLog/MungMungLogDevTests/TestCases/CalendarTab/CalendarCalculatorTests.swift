//
//  CalendarCalculatorTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/11.
//

import XCTest
@testable import MungMungLog

class CalendarCalculatorTests: XCTestCase {
    var sut: CalendarCalculator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalendarCalculator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_calendar_whenInit_shouldCurrentCalendar() {
        XCTAssertEqual(Calendar.current, sut.calendar)
    }
    
    private func givenCretaDate(year: Int, month: Int, day: Int) -> Date {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.timeZone = sut.calendar.timeZone
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date: Date = sut.calendar.date(from: dateComponents)!
        
        return date
    }
    
    func test_extractDaysInMonth_whenCalled_shouldReturnCollectDays() {
        let date20210710: Date = givenCretaDate(year: 2021, month: 07, day: 10)
        
        let days: Int = sut.extractDaysInMonth(date: date20210710)
        
        XCTAssertEqual(31, days)
    }
    
    func test_extractDayOfMonth_whenCalled_shouldReturnDay() {
        let date20210710: Date = givenCretaDate(year: 2021, month: 07, day: 10)
        
        let day: Int = sut.extractDayOfMonth(date: date20210710)
        
        XCTAssertEqual(10, day)
    }

    func test_createFirstDateOfMonth_whenCalled_shouldReturnFirstdateOfMonth() {
        let date20210701: Date = givenCretaDate(year: 2021, month: 07, day: 01)
        let date20210710: Date = givenCretaDate(year: 2021, month: 07, day: 10)
        
        let firstDate: Date = sut.createFirstDateOfMonth(date: date20210710)
        
        XCTAssertEqual(date20210701, firstDate)
    }

}
