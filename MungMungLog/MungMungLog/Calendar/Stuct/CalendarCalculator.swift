//
//  CalendarCalculator.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/11.
//

import Foundation


// TODO: - Error 처리를 할것인지 optional로 보낼것인지 기본값을 줄것인지 셋중에 하나 선택하자.

// 21.07.10 -> 31
struct CalendarCalculator: CalendarHelper {
    public func extractDaysInMonth(date: Date) -> Int {
        guard let days: Range<Int> = calendar.range(of: .day, in: .month, for: date) else {
            return 30
        }
        
        return days.count
    }
    
    // 21.07.10 -> 10
    public func extractDayOfMonth(date: Date) -> Int {
        let day: Int = calendar.component(.day, from: date)
        
        return day
    }
    
    // 21.07.10 -> 21.07.01
    public func createFirstDateOfMonth(date: Date) -> Date {
        let components: DateComponents = calendar.dateComponents([.year, .month], from: date)
        
        guard let firstDate: Date = calendar.date(from: components) else {
            return Date()
        }
        
        return firstDate
    }
    
    // 21.07.10 -> 7(sat)
    public func calculateWeekday(date: Date) -> Int {
        let weekday: Int = calendar.component(.weekday, from: date)
        
        return weekday
    }
}
