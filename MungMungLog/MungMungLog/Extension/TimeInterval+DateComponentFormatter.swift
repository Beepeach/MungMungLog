//
//  TimeInterval+DateComponentFormatter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/19.
//

import Foundation

extension TimeInterval {
    private static let timerFormatter: DateComponentsFormatter = {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        return formatter
    }()
    
    // 3600 -> 01:00:00
    public var timerFormatted: String? {
        return TimeInterval.timerFormatter.string(from: self)
    }

    private static let timerFormatterWithBriefStyle: DateComponentsFormatter = {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        
        return formatter
    }()
    
    // 3661 -> 1hour 1min 1sec
    public var timerFormattedWithBriefStyle: String? {
        return TimeInterval.timerFormatterWithBriefStyle.string(from: self)
    }
    
    // 3600 -> 1
    private static func convertTimeIntervalToHour(_ timeInterval: Double) -> Int {
        return Int(timeInterval) / 3600
    }
    
    // 3660 -> 1
    private static func convertTimeIntervalToMin(_ timeInterval: Double) -> Int {
        return (Int(timeInterval) % 3600) / 60
    }
    
    // 3660 -> 1시간 1분
    private static func contertTimeIntervalToKoreaHourAndMin(_ timeInterval: Double) -> String {
        let hour: Int = TimeInterval.convertTimeIntervalToHour(timeInterval)
        let min: Int = TimeInterval.convertTimeIntervalToMin(timeInterval)
        let timeString: String = "\(hour)시간 \(min)분"
        
        return timeString
    }
    
    // 3600 -> 1시간 0분
    public var timerFormattedWithKoreaHourAndMin: String {
        return TimeInterval.contertTimeIntervalToKoreaHourAndMin(self)
    }
    
}
