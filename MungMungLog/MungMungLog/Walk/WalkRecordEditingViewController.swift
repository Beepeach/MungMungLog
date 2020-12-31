//
//  RecodEditingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/09.
//

import UIKit

class WalkRecordEditingViewController: UIViewController {
    
    var walkRecordTime: Int = 0
    
    @IBOutlet weak var walkDateAndTimeLabel: UILabel!
    @IBOutlet weak var walkRecordTimeLabel: UILabel!
    
    
    @objc func changeWalkDateAndTimeLabel(notification: Notification) {
        guard let walkDateAndTime = notification.userInfo?["WalkDateAndTime"] as? [String],
              let walkDate = walkDateAndTime.first,
              let walkTime = walkDateAndTime.last else {
            return
        }
        
        self.walkDateAndTimeLabel.text = "\(walkDate)\n\(walkTime)"
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentTwoButtonAlert(alertTitle: "기록을 중지하시겠어요?", message: "중지하시면 현재 데이터가 삭제됩니다.", confirmActionTitle: "확인", cancelActionTitle: "취소") {_ in
            
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        print("save")
        // ToDo
        // 데이터베이스에 산책데이터를 저장하는 코드
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let formattedWalkingTime = timerStringFormatter.string(from: Double(walkRecordTime)) {
            walkRecordTimeLabel.text = "산책 시간: \(formattedWalkingTime)"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeWalkDateAndTimeLabel(notification:)), name: NSNotification.Name.DateValueDidChange, object: nil)
    }
}

