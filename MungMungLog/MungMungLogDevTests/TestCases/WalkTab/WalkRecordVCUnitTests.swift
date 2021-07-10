//
//  WalkRecordVCUnitTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/05/13.
//

import XCTest
@testable import MungMungLog

class WalkRecordVCUnitTests: XCTestCase {
    
    var sut: WalkRecordViewController!

    override func setUpWithError() throws {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "WalkRecordViewController") as! WalkRecordViewController)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testTimer_whenViewDidLoad_TimerNotNil() {
        XCTAssertNotNil(sut.timer)
    }
    
    
}
