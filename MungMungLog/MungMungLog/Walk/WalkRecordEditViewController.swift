//
//  WalkRecordEditViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/18.
//

import UIKit
import CoreLocation
import MapKit

class WalkRecordEditViewController: UIViewController {
    var coordinateList: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    
    @IBOutlet weak var totalWalkTimeLabel: UILabel!
    @IBOutlet weak var totalWalkDistanceLabel: UILabel!
    @IBOutlet weak var walkStartDateLabel: UILabel!
    @IBOutlet weak var walkEndDateLabel: UILabel!
    @IBOutlet weak var walkStartTimeLabel: UILabel!
    @IBOutlet weak var walkEndTimeLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var walkRecordTitleField: UITextField!
    @IBOutlet weak var walkRecordContentsTextView: UITextView!
    
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
            
            if let walkCoordinateList = userInfo["walkCoordinateList"] as? [CLLocationCoordinate2D] {
                
                self.coordinateList = walkCoordinateList
                
                let line: MKPolyline = MKPolyline(coordinates: self.coordinateList, count: self.coordinateList.count)
                
                self.mapView.addOverlay(line)
                
                self.moveStartLocation()
            }
        }
    }
    
    func setWalkRecordContentsTextViewToPlaceHolder() {
        walkRecordContentsTextView.text = "오늘 산책을 기록해 보세요."
        walkRecordContentsTextView.textColor = .lightGray
    }
    
    func moveStartLocation() {
        guard let startLocation: CLLocationCoordinate2D = coordinateList.first else { return }
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: startLocation, latitudinalMeters: CLLocationDistance(2000), longitudinalMeters: CLLocationDistance(2000))
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func saveWalkRecord(_ sender: Any) {
        let actionSheet = UIAlertController(title: "알림", message: "산책기록을 저장하시겠습니까?", preferredStyle: .actionSheet)
        
        let save = UIAlertAction(title: "저장", style: .default) { _ in
            
        }
        actionSheet.addAction(save)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        
        let delete = UIAlertAction(title: "기록 삭제", style: .destructive) { _ in
            self.presentTwoButtonAlert(alertTitle: "알림", message: "정말 기록을 삭제하시겠어요??\n확인을 누르시면 기록이 삭제됩니다.", confirmActionTitle: "확인", cancelActionTitle: "취소") { _ in
                self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
            }
        }
        actionSheet.addAction(delete)
        
        present(actionSheet, animated: true, completion: nil)
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


extension WalkRecordEditViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer: MKPolylineRenderer = MKPolylineRenderer(polyline: polyline)
            renderer.lineWidth = 10
            renderer.strokeColor = .systemTeal
            
            return renderer
        }
        
        // polyline이 없다면 어떻게할까??
        return MKOverlayRenderer()
    }
}
