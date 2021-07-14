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
}
