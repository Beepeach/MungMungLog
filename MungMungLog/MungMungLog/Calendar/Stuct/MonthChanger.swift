//
//  MonthChanger.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/10.
//

import Foundation

struct MonthChanger: CalendarHelper {
    public func plusOneMonth(date: Date) -> Date {
        guard let result: Date = calendar.date(byAdding: .month, value: 1, to: date) else {
             return Date()
        }
        
        return result
    }
    
    public func minusOneMonth(date: Date) -> Date {
        guard let result: Date = calendar.date(byAdding: .month, value: -1, to: date) else {
            return Date()
        }
        
        return result
    }
}
