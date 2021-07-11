//
//  DaySquareGeneratorTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/11.
//

import XCTest
@testable import MungMungLog

class DaySquareGeneratorTests: XCTestCase {
    var sut: DaySquareGenerator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DaySquareGenerator()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_calendar_whenInit_shouldCurrentCalendar() {
        XCTAssertEqual(Calendar.current, sut.calendar)
    }
    
    private func givenCretaDate20210710() -> Date {
        var dateComponents: DateComponents = DateComponents()
        dateComponents.timeZone = sut.calendar.timeZone
        dateComponents.year = 2021
        dateComponents.month = 7
        dateComponents.day = 10
        
        let date: Date = sut.calendar.date(from: dateComponents)!
        
        return date
    }
    
    func test_create_shouldFill42Squares() {
        let date: Date = givenCretaDate20210710()
        let totalSquares: [String] = sut.create(date: date)
        
        XCTAssertEqual(42, totalSquares.count)
    }
    
    func test_create_shouldFillCollectDays() {
        let date: Date = givenCretaDate20210710()
        
        let vaildSquares: [String] = sut.create(date: date).filter { !$0.isEmpty }
        let vaildSquaresCount: Int = vaildSquares.count
        
        XCTAssertEqual(31, vaildSquaresCount)
    }

    func test_create_shouldFillCollectFrountEmptyDay() {
        let date: Date = givenCretaDate20210710()
        let firstDayOrderOf202107: Int = 4
        
        let firstDayOrder: Int = sut.create(date: date).firstIndex { $0 == "1" }!
        
        XCTAssertEqual(firstDayOrderOf202107, firstDayOrder)
    }
}
