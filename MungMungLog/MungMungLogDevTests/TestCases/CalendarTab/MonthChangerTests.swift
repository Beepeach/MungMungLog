//
//  MonthChanger.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/07/10.
//

import XCTest
@testable import MungMungLog

class MonthChangerTests: XCTestCase {
    var sut: MonthChanger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MonthChanger()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
}
