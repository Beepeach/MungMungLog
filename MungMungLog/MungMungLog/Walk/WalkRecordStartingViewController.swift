//
//  RecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/28.
//

import UIKit
import CoreLocation
import SwiftKeychainWrapper

class WalkRecordStartingViewController: UIViewController {
    lazy var locationManager: CLLocationManager = {
        let manager: CLLocationManager = CLLocationManager()
        
        return manager
    }()
    
    @IBAction func startWalkRecord(_ sender: Any) {
        if let _ = KeychainWrapper.standard.integer(forKey: .apiFamilyId) {
            performSegue(withIdentifier: MovetoView.walkRecode.rawValue, sender: nil)
        } else {
            presentOneButtonAlert(alertTitle: "알림", message: "반려견을 등록해주세요.", actionTitle: "확인")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 지도를 사용할건지 묻는걸 여기에서 물어보자.
        let status: CLAuthorizationStatus
        
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                status = locationManager.authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                presentNotUsingLocationServiceAlert()
            case .authorizedAlways, .authorizedWhenInUse:
                fallthrough
            @unknown default:
                break
            }
        } else {
            presentNotProvideLocationServiceInDeviceAlert()
        }
    }
    
    private func presentNotUsingLocationServiceAlert() {
        self.presentOneButtonAlert(alertTitle: "알림", message: "위치 서비스를 사용할 수 없습니다.\n위치 서비스 허용 여부를 확인해주세요.", actionTitle: "확인")
    }
    
    private func presentNotProvideLocationServiceInDeviceAlert() {
        self.presentOneButtonAlert(alertTitle: "알림", message: "위치 서비스를 제공하지 않는 기기입니다.", actionTitle: "확인")
    }
    
}
