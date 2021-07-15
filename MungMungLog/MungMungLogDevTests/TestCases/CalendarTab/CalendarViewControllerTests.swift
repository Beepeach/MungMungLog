//
//  CalendarViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/09.
//

import XCTest
@testable import MungMungLog

class CalendarViewControllerTests: XCTestCase {
    var sut: CalendarViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_selectedDate_shouldSetAndReturn() {
        let date: Date = Date()
        
        sut.setSelectedDate(date: date)
        
        XCTAssertEqual(date, sut.getSelectedDate())
    }
    
    func test_datasoure_whenViewDidLoad_shouldSet() {
        sut.viewDidLoad()
        XCTAssertTrue(sut.collectionView.dataSource === sut)
    }
    
    func test_delegate_whenViewDidLoad_shouldSet() {
        sut.viewDidLoad()
        XCTAssertTrue(sut.collectionView.delegate === sut)
    }
    
    func test_totalCellCount_whenViewDidLoad_should42Counts() {
        sut.viewDidLoad()
        
        let count: Int = sut.collectionView.numberOfItems(inSection: 0)
        
        XCTAssertEqual(42, count)
    }
    
    func test_increaseMonthbutton_whenTap_shouldIncreaseSelectedDate() {
        let beforeDate: Date = sut.getSelectedDate()
        
        sut.increaseMonth(sut as Any)
        
        let afterDate: Date = sut.getSelectedDate()
        
        XCTAssertGreaterThan(afterDate, beforeDate)
    }
    
    func test_decreaseMonthButton_whenTap_shouldDecreaseSelectedDate() {
        let beforeDate: Date = sut.getSelectedDate()
        
        sut.decreaseMonth(sut as Any)
        
        let afterDate: Date = sut.getSelectedDate()
        
        XCTAssertLessThan(afterDate, beforeDate)
    }
    
    func givenDate20210701() -> Date {
        var datecomponent: DateComponents = DateComponents()
        datecomponent.timeZone = TimeZone(abbreviation: "UTC")
        datecomponent.year = 2021
        datecomponent.month = 7
        
        let date: Date = Calendar.current.date(from: datecomponent
        )!
        
        return date
    }
    
    func test_cell_whenDateisEmpty_shouldNotSelected() {
        let date: Date = givenDate20210701()
        let indexPath: IndexPath = IndexPath(item: 0, section: 0)
        sut.setSelectedDate(date: date)
        
        XCTAssertFalse(sut.collectionView.delegate!.collectionView!(sut.collectionView, shouldSelectItemAt: indexPath))
    }
    
    func test_cell_whenDateisVaild_shouldSelected() {
        let date: Date = givenDate20210701()
        let indexPath: IndexPath = IndexPath(item: 5, section: 0)
        
        sut.setSelectedDate(date: date)
        
        XCTAssertTrue(sut.collectionView.delegate!.collectionView!(sut.collectionView, shouldSelectItemAt: indexPath))
    }
    
    func test_cell_whenInit_shouldHaveCollectDate() {
        let date: Date = givenDate20210701()
        let indexPath: IndexPath = IndexPath(item: 4, section: 0)
        
        let cell: DaySquareCollectionViewCell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: indexPath) as! DaySquareCollectionViewCell
        
        XCTAssertEqual(date, cell.getDate())
    }
}
