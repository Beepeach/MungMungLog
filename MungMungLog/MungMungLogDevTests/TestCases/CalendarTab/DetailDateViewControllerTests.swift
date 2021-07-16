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
}
