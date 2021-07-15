//
//  DateGenerator.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/15.
//

import Foundation

struct DateGenerator: CalendarHelper {
    public func create(year: Int, month: Int, day: Int) -> Date? {
        var components: DateComponents = DateComponents()
        components.timeZone = TimeZone(abbreviation: "UTC")
        components.year = year
        components.month = month
        components.day = day
        
        let date: Date? = calendar.date(from: components)
        
        return date
    }
}
