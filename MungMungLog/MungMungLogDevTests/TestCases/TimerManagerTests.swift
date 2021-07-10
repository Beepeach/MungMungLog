//
//  TimerManagerTests.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/05/14.
//

import XCTest
@testable import MungMungLog

class TimerManagerTests: XCTestCase {
    var sut: TimerManager!

    override func setUpWithError() throws {
        sut = TimerManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInit_whenDefaultInit_timeCountIsZero() {
        XCTAssertEqual(sut.timeCount, 0)
    }
    
    func testInit_whenInputTimeCountPrams_timeCountIsCollectTime() {
        let randomNum: Int = Int.random(in: 1 ... 1000)
        sut = TimerManager(timeCount: Double(randomNum))
        
        XCTAssertEqual(sut.timeCount, Double(randomNum))
    }
    
    func testResetTimeCount_timeCountIsZero() {
        sut.timeCount = Double(Int.random(in: 1 ... 1000))
        sut.resetTimeCount()
        
        XCTAssertEqual(sut.timeCount, 0)
    }
    
    func testReturnTimeCount_returnCollectTimeCount() {
        sut.timeCount = Double(Int.random(in: 1 ... 1000))
        let returnTimeCount = sut.returnTimeCount()
        
        XCTAssertEqual(sut.timeCount, returnTimeCount)
    }
    
    func testStartRecordingTimeCount_mainTimerIsValid() {
        sut.startRecordingTimeCount()
        
        XCTAssertTrue(sut.mainTimer!.isValid)
    }
    
    func testStopRecoding_mainTimerIsNil() {
        sut.mainTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            print("testing")
        })
        
        sut.stopRecording()
        
        XCTAssertNil(sut.mainTimer)
    }
    
    func testAddBackgroundTime_increaseTimeCount() {
        let randomStartTimeCount: Int = Int.random(in: 1 ... 1000)
        let randomBackgroundTimeCount: Int = Int.random(in: 1 ... 1000)
        let totalTimeCount: Int = randomStartTimeCount + randomBackgroundTimeCount
        
        sut.timeCount = Double(randomStartTimeCount)
        sut.addBackgroundTime(time: Double(randomBackgroundTimeCount))
        
        XCTAssertEqual(sut.timeCount, Double(totalTimeCount))
    }
    
}
