//
//  WalkRecordStartingVCUnitTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/05/12.
//

import XCTest
@testable import MungMungLog

class WalkRecordStartingVCUnitTests: XCTestCase {
    var sut: WalkRecordStartingViewController!
    
    override func setUpWithError() throws {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(identifier: "WalkRecordStartingViewController") as! WalkRecordStartingViewController)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}
