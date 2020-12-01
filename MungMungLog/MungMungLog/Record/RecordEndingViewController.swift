//
//  RecordEndingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/01.
//

import UIKit

class RecordEndingViewController: UIViewController {

    @IBAction func stopRecord(_ sender: Any) {
        presentTwoButtonAlert(alertTitle: "산책을 마치셨나요?", message: "지금까지의 기록을 저장하시려면 저장을 눌러주세요.", confirmActionTitle: "저장", cancelActionTitle: "취소")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
