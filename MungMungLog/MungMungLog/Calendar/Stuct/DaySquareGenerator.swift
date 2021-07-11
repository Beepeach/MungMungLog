//
//  DaySquareGenerator.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/11.
//

import Foundation

struct DaySquareGenerator: CalendarHelper {
    private var DaySquares: [String] = []
    private let maxSquareCount: Int = 42
    private var count: Int = 1
    
    public mutating func create(date: Date) -> [String] {
        let daysInMonth: Int = CalendarCalculator().extractDaysInMonth(date: date)
        let firstDayOfMonth: Date = CalendarCalculator().createFirstDateOfMonth(date: date)
        let frontEmptyDay: Int = CalendarCalculator().calculateWeekday(date: firstDayOfMonth) - 1
        
        while count <= maxSquareCount {
            if (count <= frontEmptyDay) || (count > frontEmptyDay + daysInMonth) {
                DaySquares.append("")
            } else {
                DaySquares.append(String(count - frontEmptyDay))
            }
            
            
            count += 1
        }
        
        return DaySquares
    }
}
