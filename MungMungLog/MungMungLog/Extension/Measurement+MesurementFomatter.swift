//
//  Measurement+MesurementFomatter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/18.
//

import Foundation

extension Measurement where UnitType == UnitLength {
    private static let kilometerFomatted: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.numberFormatter.maximumFractionDigits = 2
        formatter.numberFormatter.minimumFractionDigits = 2
        formatter.unitOptions = .providedUnit
        
        return formatter
    }()
    
    var kilometerFormatted: String {
        Measurement.kilometerFomatted.string(from: self)
    }
}

extension Measurement where UnitType == Unit {
    
}
