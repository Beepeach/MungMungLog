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
    
    func test_monthAndDayFormatter_shouldReturnMonthAndDayString() {
        let monthAndDay: String = sut.monthAndDayFormatted
        
        XCTAssertEqual("7월 10일", monthAndDay)
    }
    
    func test_hourAndMinFormatter_shouldReturnHourAndMinString() {
        let hourAndMin: String = sut.hourAndMinuteFormatted
        
        XCTAssertEqual("00시 00분", hourAndMin)
    }
    
    func test_fullTimeKoreanDateFormatter_shouldReturnFullTimeString() {
        let fullTimeDate: String = sut.FullTimeKoreanDateFormatted
        
        XCTAssertEqual("2021년 7월 10일 00시 00분", fullTimeDate)
    }
    
    func test_koreanDateFormatter_shouldReturnKoreanDate() {
        let koreanDate: String = sut.koreanDateFormatted
        
        XCTAssertEqual("2021년 07월 10일", koreanDate)
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
