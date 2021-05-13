//
//  WalkRecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/12.
//

import UIKit
import MapKit
import CoreLocation

class WalkRecordViewController: UIViewController {
    
    var mainTimer: Timer?
    var timeCount = 0
    var pause = true
    var totalDistance: Double = 0.0
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseOrStartButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func pauseOrStart(_ sender: Any) {
        if pause == true {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartButton.imageView?.image = UIImage(named: "start")
            }
            
            pause = false
            stopTimer()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartButton.imageView?.image = UIImage(named: "pause")
            }
            
            pause = true
            startTimer()
        }
    }
    
    @IBAction func stopWalk(_ sender: Any) {
        presentTwoButtonAlert(alertTitle: "산책을 마치셨나요?", message: "지금까지의 기록을 저장하시려면 저장을 눌러주세요.", confirmActionTitle: "저장", cancelActionTitle: "취소") { _ in
            
            guard let editingNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "walkRecordEditingNavigationController") as? UINavigationController else { return }
            
            guard let editingViewController = editingNavigationController.topViewController as? WalkRecordEditingViewController else { return }
            
            editingViewController.walkRecordTime = self.timeCount
            
            editingNavigationController.modalPresentationStyle = .fullScreen
            self.present(editingNavigationController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
    
    
    func startTimer() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _IOFBF in
            DispatchQueue.global().async {
                self.timeCount += 1
                print(self.timeCount)
                DispatchQueue.main.async {
                    self.timeLabel.text = self.timerStringFormatter.string(from: Double(self.timeCount))
                }
            }
        })
    }
    
    func stopTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
}
