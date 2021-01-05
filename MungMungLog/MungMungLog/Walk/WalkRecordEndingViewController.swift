//
//  RecordEndingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/01.
//

import UIKit
import MapKit
import CoreLocation

class WalkRecordEndingViewController: UIViewController {
    
    var mainTimer: Timer?
    var timeCount = 0
    var pause = true
    
    var prevLocation: CLLocation?
    var totalDistance: Double = 0.0
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.activityType = .fitness
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        return manager
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pauseOrStartImageView: UIImageView!
    @IBOutlet weak var pauseOrStartLabel: UILabel!
    
    
    @IBAction func PauseOrStart(_ sender: UIButton) {
        if pause == true {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartImageView.image = UIImage(named: "start")
                self.pauseOrStartLabel.text = "다시 시작"
            }
            
            pause = false
            stopTimer()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartImageView.image = UIImage(named: "pause")
                self.pauseOrStartLabel.text = "일시 정지"
            }
            
            pause = true
            startTimer()
        }
    }
    
    
    func startTimer() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            DispatchQueue.global().async {
                self.timeCount += 1
                print(self.timeCount)
                DispatchQueue.main.async {
                    self.timeLabel.text = self.timerStringFormatter.string(from: Double(self.timeCount))
                }
            }
        })
        
        // ToDo
        // Milsecond를 어떻게 구현할것인가 생각.
    }
    
    func stopTimer() {
        mainTimer?.invalidate()
        mainTimer = nil
    }
    
    
    @IBAction func stopRecord(_ sender: Any) {
        presentTwoButtonAlert(alertTitle: "산책을 마치셨나요?", message: "지금까지의 기록을 저장하시려면 저장을 눌러주세요.", confirmActionTitle: "저장", cancelActionTitle: "취소") {_ in
            
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
        
        if CLLocationManager.locationServicesEnabled() {
            var status: CLAuthorizationStatus
            
            if #available(iOS 14.0, *) {
                status = locationManager.authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                updateLocation()
            case .denied, .restricted:
                presentNotUsingLocationServiceAlert()
            @unknown default:
                presentNotUsingLocationServiceAlert()
            }
        } else {
            presentNotUsingLocationServiceAlert()
        }
    }
    
    func presentNotUsingLocationServiceAlert() {
        self.presentOneButtonAlert(alertTitle: "알림", message: "위치서비스를 사용할 수 없습니다.", actionTitle: "확인")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
}


extension WalkRecordEndingViewController: CLLocationManagerDelegate {
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            updateLocation()
        default:
            self.presentNotUsingLocationServiceAlert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            updateLocation()
        default:
            self.presentNotUsingLocationServiceAlert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationManager.stopUpdatingLocation()
        presentNotUsingLocationServiceAlert()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        if let prevLocation = prevLocation {
            totalDistance += prevLocation.distance(from: location)
            // ToDo
            // 총 이동거리 Label에 표시
        }
        
        prevLocation = location
        // ToDo
        // MoveToCurrentLocation()
    }
}
