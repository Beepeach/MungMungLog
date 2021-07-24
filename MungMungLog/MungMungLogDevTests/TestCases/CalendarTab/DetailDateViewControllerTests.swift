//
//  DetailDateViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/15.
//

import XCTest
@testable import MungMungLog

class DetailDateViewControllerTests: XCTestCase {
    var sut: DetailDateViewController!
    var nav: UINavigationController!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "DetailDateViewController") as! DetailDateViewController)
        sut.loadViewIfNeeded()
        
        nav = UINavigationController(rootViewController: sut)
        
    }

    override func tearDownWithError() throws {
        sut = nil
        nav = nil
        
        try super.tearDownWithError()
    }
    
    func test_navigationTitle_whenViewDidLoad_shouldSetCellDate() {
        
        
    }
    
    func test_delegate_whenViewDidLoad_shouldSet() {
        XCTAssertTrue(sut.recordCategoryCollectionView.delegate === sut)
    }
    
    
    func test_recordCategoryCellCount_shouldSet5Counts() {
        sut.viewDidLoad()
        
        let count: Int = sut.recordCategoryCollectionView.numberOfItems(inSection: 0)
        
        XCTAssertEqual(5, count)
    }
    
    func test_recordCategoryCellHeight_shouldSet100() {
        let cell: UICollectionViewCell = sut.recordCategoryCollectionView.dataSource!.collectionView(sut.recordCategoryCollectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        let height: CGFloat = cell.frame.size.height
        
        XCTAssertEqual(height, 100)
    }
    
    func test_recordCategoryCellWidth_shouldSetOneOverThreePointfiveOfTheView() {
        let cell: UICollectionViewCell = sut.recordCategoryCollectionView.dataSource!.collectionView(sut.recordCategoryCollectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        let inset: CGFloat = 40
        let containerViewWidth = sut.view.frame.width - inset
        
        
        let width: CGFloat = cell.frame.size.width
        
        
        
        let expectedWitdth: CGFloat = containerViewWidth * (1 / 3.5)
        
        XCTAssertEqual(width, expectedWitdth.rounded(.down))
    }
}
