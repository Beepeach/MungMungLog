//
//  TimerManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/17.
//

import Foundation

class TimerManager {
    var mainTimer: Timer?
    var timeCount: Double
    
    init(timeCount: Double = 0.0) {
        self.timeCount = timeCount
    }
    
    func returnTimeCount() -> Double {
        return timeCount
    }
    
    func startRecordingTimeCount() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            DispatchQueue.global().async {
                self.timeCount += 1
                print(self.timeCount)
            }
        })
    }
    
    func stopRecording() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    
    func addBackgroundTime(time: Double) {
        timeCount += time
    }
    
    func resetTimeCount() {
        timeCount = 0
    }
}
