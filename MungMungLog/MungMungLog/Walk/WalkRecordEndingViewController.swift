//
//  RecordEndingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/01.
//

import UIKit

class WalkRecordEndingViewController: UIViewController {
    
    var timer: Timer?
    var timeCount = 0
    
    var pause = true
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var milliSecondLabel: UILabel!
    
    @IBOutlet weak var pauseOrStartImageView: UIImageView!
    @IBOutlet weak var pauseOrStartLabel: UILabel!
    
    
    @IBAction func PauseOrStart(_ sender: UIButton) {
        if pause == true {
            UIView.animate(withDuration: 0.3) {
                self.pauseOrStartImageView.image = UIImage(named: "start")
                self.pauseOrStartLabel.text = "다시 시작"
            }
            
            pause = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.pauseOrStartImageView.image = UIImage(named: "pause")
                self.pauseOrStartLabel.text = "일시 정지"
            }
            
            pause = true
            
            // ToDo
            // 타이머 구현
        }
    }
    
    
    
    @IBAction func stopRecord(_ sender: Any) {
        presentTwoButtonAlert(alertTitle: "산책을 마치셨나요?", message: "지금까지의 기록을 저장하시려면 저장을 눌러주세요.", confirmActionTitle: "저장", cancelActionTitle: "취소") {_ in
            guard let editingViewController = self.storyboard?.instantiateViewController(withIdentifier: "walkRecordEditingViewController") else { return }
            
            editingViewController.modalPresentationStyle = .fullScreen
            self.present(editingViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
