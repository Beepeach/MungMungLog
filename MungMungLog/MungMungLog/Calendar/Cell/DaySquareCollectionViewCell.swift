//
//  DaySquareCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/13.
//

import UIKit

class DaySquareCollectionViewCell: UICollectionViewCell {
    private var date: Date?
    
    @IBOutlet weak var dayOfMonthLabel: UILabel!
    
    public func getDate() -> Date? {
        return date
    }
    
    public func setDate(date: Date) {
        self.date = date
    }
}
