//
//  CommonDecodableTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/04/14.
//

import XCTest
@testable import MungMungLog_Dev

class CommonDecodableTests<TestModel: Decodable>: XCTestCase {
    
    var sut: TestModel!
    var decoder: JSONDecoder!
    var data: Data!

    override func setUpWithError() throws {
        decoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        sut = nil
        decoder = nil
        data = nil
    }
    
    func testConformance_conformsToDecodable() {
        XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func testDecoding() throws {
        let url = Bundle(for: Self.self).url(forResource: "\(TestModel.self)", withExtension: "json")!
        
        data = try Data(contentsOf: url)
        
        XCTAssertNoThrow(try decoder.decode(TestModel.self, from: data))
    }
    
}
