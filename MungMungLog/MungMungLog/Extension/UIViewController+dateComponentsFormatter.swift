//
//  UIViewController+dateComponentsFormatter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/26.
//

import UIKit
import Foundation


extension UIViewController {
    var timerStringFormatter: DateComponentsFormatter {
        let timerFormatter = DateComponentsFormatter()
        timerFormatter.unitsStyle = .positional
        timerFormatter.allowedUnits = [.hour, .minute, .second]
        timerFormatter.zeroFormattingBehavior = [.pad]
        
        return timerFormatter
    }
}
