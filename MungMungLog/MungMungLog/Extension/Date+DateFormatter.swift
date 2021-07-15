//
//  Date+DateFormatter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/19.
//

import Foundation

extension DateFormatter {
    public static let koreanDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        
        return formatter
    }()
}

extension Date {
    // 5월 19일
    public var monthAndDayFormatted: String {
        return Date.monthAndDayFormatter.string(from: self)
    }
    
    private static let monthAndDayFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "MMM dd일"
        
        return formatter
    }()
    

    
    // 17시 17분
    public var hourAndMinuteFormatted: String {
        return Date.hourAndMinuteFormatter.string(from: self)
    }
    
    private static let hourAndMinuteFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "HH시 mm분"
        
        return formatter
    }()
    

    
    // 2021년 5월 19일 17시 17분
    public var FullTimeKoreanDateFormatted: String {
        return Date.FullTimeKoreanDateFormatter.string(from: self)
    }
    
    private static let FullTimeKoreanDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter.koreanDateFormatter
        formatter.dateFormat = "YYYY년 MMM dd일 HH시 mm분"
        
        return formatter
    }()
    
    // 2021년 07월 10일
    public var koreanDateFormatted: String {
        return Date.koreanDateFormatter.string(from: self)
    }
    
    private static let koreanDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    // Date -> 2021년
    public var yearFormatted: String {
        return Date.yearFormatter.string(from: self)
    }
    
    private static let yearFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년"
        
        return formatter
    }()
    
    // Date -> 07월
    public var monthFormatted: String {
        return Date.monthFormatter.string(from: self)
    }
    
    private static let monthFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM월"
        
        return formatter
    }()
}
