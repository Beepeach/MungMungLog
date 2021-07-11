//
//  MonthChanger.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/10.
//

import Foundation

struct MonthChanger: CalendarHelper {
    
    // 2021.07.10 -> 2121.08.10
    public func plusOneMonth(date: Date) -> Date {
        guard let result: Date = calendar.date(byAdding: .month, value: 1, to: date) else {
             return Date()
        }
        
        return result
    }
    
    // 2021.07.10 -> 2021.06.10
    public func minusOneMonth(date: Date) -> Date {
        guard let result: Date = calendar.date(byAdding: .month, value: -1, to: date) else {
            return Date()
        }
        
        return result
    }
}
