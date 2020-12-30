//
//  RecodEditingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/09.
//

import UIKit

class WalkRecordEditingViewController: UIViewController {

    var walkingTime: Int = 0
    
    @IBOutlet weak var walkDateAndTimeLabel: UILabel!
    @IBOutlet weak var walkingTimeLabel: UILabel!
    
    
    @IBAction func save(_ sender: Any) {
        print("save")
        // ToDo
        // 데이터베이스에 산책데이터를 저장하는 코드
        
        // unwind와 같이 사용해도 괜찮은지??
    }
    
    @IBAction func unwindToWalkRecordEditingVC(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let formattedWalkingTime = timerStringFormatter.string(from: Double(walkingTime)) {
            walkingTimeLabel.text = "산책 시간: \(formattedWalkingTime)"
        }
    }
}
