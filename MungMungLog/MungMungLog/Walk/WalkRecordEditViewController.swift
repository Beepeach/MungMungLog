//
//  WalkRecordEditViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/18.
//

import UIKit

class WalkRecordEditViewController: UIViewController {
    
    @IBOutlet weak var totalWalkTimeLabel: UILabel!
    @IBOutlet weak var totalWalkDistanceLabel: UILabel!
    @IBOutlet weak var walkStartDateLabel: UILabel!
    @IBOutlet weak var walkEndDateLabel: UILabel!
    @IBOutlet weak var walkStartTimeLabel: UILabel!
    @IBOutlet weak var walkEndTimeLabel: UILabel!
    
    
    @IBOutlet weak var walkRecordTitleField: UITextField!
    @IBOutlet weak var walkRecordContentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .willEndRecodingWalkRecord, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo else {
                return
            }
            
            if let walkStartDate = userInfo["walkStartDate"] as? Date {
                self.walkStartDateLabel.text = "\(walkStartDate)"
                self.walkStartTimeLabel.text = "\(walkStartDate)"
            }
            
            if let walkEndDate = userInfo["walkEndDate"] as? Date {
                self.walkEndDateLabel.text = "\(walkEndDate)"
                self.walkEndTimeLabel.text = "\(walkEndDate)"
            }
            
            if let totalWalkTime = userInfo["totalWalkTime"] as? Int
            {
                let totalWalkTimeInterval = Double(totalWalkTime)
                self.totalWalkTimeLabel.text = self.timerStringFormatter.string(from: totalWalkTimeInterval)
            }
            
            if let totalWalkDistance = userInfo["totalWalkDistance"] as? Double {
                self.totalWalkDistanceLabel.text = Measurement(value: totalWalkDistance / 1000, unit: UnitLength.kilometers).kilometerFormatted
            }
        }
    }
}
