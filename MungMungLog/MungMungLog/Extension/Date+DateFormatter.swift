//
//  Date+DateFormatter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/19.
//

import Foundation


extension Date {
    private static let monthAndDayFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MMM dd일"
        
        return formatter
    }()
    
    // 5월 19일
    public var monthAndDayFormatted: String {
        return Date.monthAndDayFormatter.string(from: self)
    }
    
    private static let hourAndMinuteFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "HH시 mm분"
        
        return formatter
    }()
    
    // 17시 17분
    public var hourAndMinuteFormatted: String {
        return Date.hourAndMinuteFormatter.string(from: self)
    }
}
