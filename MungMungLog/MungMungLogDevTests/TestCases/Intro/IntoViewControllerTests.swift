//
//  IntoViewControllerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/08/20.
//

import XCTest
@testable import MungMungLog

class IntoViewControllerTests: XCTestCase {
    var sut: IntroViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
