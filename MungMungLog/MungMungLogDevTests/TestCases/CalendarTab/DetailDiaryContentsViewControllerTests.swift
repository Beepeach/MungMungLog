//
//  DetailDiaryContentsViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/31.
//

import XCTest
@testable import MungMungLog

class DetailDiaryContentsViewControllerTests: XCTestCase {
    var sut: DetailDiaryContentsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "DetailDiaryContentsViewController") as! DetailDiaryContentsViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
