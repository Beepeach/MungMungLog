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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var walkRecordTitleField: UITextField!
    @IBOutlet weak var walkRecordContentsTextView: UITextView!
    
    func setWalkRecordContentsTextViewToPlaceHolder() {
        walkRecordContentsTextView.text = "오늘 산책을 기록해 보세요."
        walkRecordContentsTextView.textColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWalkRecordContentsTextViewToPlaceHolder()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo else { return }
            guard let keyboardBound = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardBound.height, right: 0)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    
        NotificationCenter.default.addObserver(forName: .willEndRecodingWalkRecord, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo else {
                return
            }
            
            if let walkStartDate = userInfo["walkStartDate"] as? Date {
                self.walkStartDateLabel.text = walkStartDate.monthAndDayFormatted
                self.walkStartTimeLabel.text = walkStartDate.hourAndMinuteFormatted
            }
            
            if let walkEndDate = userInfo["walkEndDate"] as? Date {
                self.walkEndDateLabel.text = walkEndDate.monthAndDayFormatted
                self.walkEndTimeLabel.text = walkEndDate.hourAndMinuteFormatted
            }
            
            if let totalWalkTime = userInfo["totalWalkTime"] as? Double
            {
                self.totalWalkTimeLabel.text = totalWalkTime.timerFormattedWithKoreaHourAndMin
            }
            
            if let totalWalkDistance = userInfo["totalWalkDistance"] as? Double {
                self.totalWalkDistanceLabel.text = Measurement(value: totalWalkDistance / 1000, unit: UnitLength.kilometers).kilometerFormatted
            }
        }
    }
}


extension WalkRecordEditViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if walkRecordContentsTextView.textColor == .lightGray {
            walkRecordContentsTextView.text = nil
            
            if #available(iOS 12.0, *) {
                walkRecordContentsTextView.textColor = self.traitCollection.userInterfaceStyle == .dark ? .white : .black
            } else {
                walkRecordContentsTextView.textColor = .black
            }
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if walkRecordContentsTextView.text.isEmpty {
            setWalkRecordContentsTextViewToPlaceHolder()
        }
    }
}
