//
//  WalkRecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/12.
//

import UIKit
import MapKit
import CoreLocation

class TimerManager {
    var mainTimer: Timer?
    var timeCount: Int
    
    init(timeCount: Int = 0) {
        self.timeCount = timeCount
    }
    
    func returnTimeCount() -> Int {
        return timeCount
    }
    
    func startRecordingTimeCount() {
            mainTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                DispatchQueue.global().async {
                    self.timeCount += 1
                    print(self.timeCount)
                }
            })
    }
    
    func stopRecording() {
            mainTimer?.invalidate()
            mainTimer = nil
    }
    
    func addBackgroundTime(time: Int) {
        timeCount += time
    }
    
    func resetTimeCount() {
        timeCount = 0
    }
}

class WalkRecordViewController: UIViewController {
    
    var pause: Bool = false
    var refreshTimer: Timer?
    var timer: TimerManager = TimerManager(timeCount: 0)
    
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
                self.pauseOrStartButton.setImage(UIImage(named: "pause"), for: .normal)
            }

            timer.startRecordingTimeCount()
            pause = false
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartButton.setImage(UIImage(named: "start"), for: .normal)
            }
            
            timer.stopRecording()
            pause = true
        }
    }
    
    @IBAction func stopWalk(_ sender: Any) {
        presentTwoButtonAlert(alertTitle: "산책을 마치셨나요?", message: "지금까지의 기록을 저장하시려면 저장을 눌러주세요.", confirmActionTitle: "저장", cancelActionTitle: "취소") { _ in
            
            guard let editingNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "walkRecordEditingNavigationController") as? UINavigationController else { return }
            
            guard let editingViewController = editingNavigationController.topViewController as? WalkRecordEditingViewController else { return }
            
//            editingViewController.walkRecordTime = self.timeCount
            
            editingNavigationController.modalPresentationStyle = .fullScreen
            self.present(editingNavigationController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.startRecordingTimeCount()
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.timeLabel.text = self.timerStringFormatter.string(from: Double(self.timer.returnTimeCount()))
                }
            }
        })
        
        NotificationCenter.default.addObserver(forName: .sceneWillEnterForeground, object: nil, queue: .main) { noti in
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let elaspedTime = userInfo["elaspedTime"] as? Int else {
                return
            }
            
            if self.pause == false {
                self.timer.addBackgroundTime(time: elaspedTime)
            }
        }
        
        NotificationCenter.default.addObserver(forName: .sceneDidEnterBackground, object: nil, queue: .main) { _ in
            print(#function)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.stopRecording()
    }
}
