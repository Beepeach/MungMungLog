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
    var labelRefreshTimer: Timer?
    var timer: TimerManager = TimerManager(timeCount: 0)
    
    var totalDistance: Double = 0.0
    var isRefreshTotalDistance: Bool = true
    var prevLocation: CLLocation?
    var currentLocation: CLLocation?
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.activityType = .fitness
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
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
            isRefreshTotalDistance = true
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.pauseOrStartButton.setImage(UIImage(named: "start"), for: .normal)
            }
            
            timer.stopRecording()
            pause = true
            isRefreshTotalDistance = false
        }
    }
    
    @IBAction func moveToCurrentLocation(_ sender: Any) {
        if let currentLocation = currentLocation {
            self.moveToCurrentLocation(location: currentLocation)
        }
    }
    
    func moveToCurrentLocation(location: CLLocation) {
        let span = CLLocationDistance(500)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: span, longitudinalMeters: span)
        
        mapView.setRegion(region, animated: true)
        mapView.setUserTrackingMode(.follow, animated: true)
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
        
        // reset prevLocation
        prevLocation = nil
        
        timer.startRecordingTimeCount()
        
        // Timer가 따로 안돌도록 하는 방법은??
        labelRefreshTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
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
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
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
        
        timer.stopRecording()
    }
}


extension WalkRecordViewController: CLLocationManagerDelegate {
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
        print(#function, error)
        locationManager.stopUpdatingLocation()
        presentNotUsingLocationServiceAlert()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 첫 실행시 지도가 움직여 distance가 급격히 증가하는 경우를 방지하기 위해 어떻게 해야할까
        
        guard let location = locations.last else { return }
        currentLocation = location
        
        if let prevLocation = prevLocation {
            if isRefreshTotalDistance == true {
                totalDistance += prevLocation.distance(from: location)
            }
        }
        
        let totalDistanceConvertedKilometer = Measurement(value: (totalDistance / 1000), unit: UnitLength.kilometers)
        
        DispatchQueue.main.async {
            self.distanceLabel.text = totalDistanceConvertedKilometer.kilometerFormatted
        }
        
        prevLocation = location
    }
    
}
