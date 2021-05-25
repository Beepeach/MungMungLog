//
//  WalkRecordEditViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/18.
//

import UIKit
import CoreLocation
import MapKit
import SwiftKeychainWrapper

class WalkRecordEditViewController: UIViewController {
    var StartDate: Double?
    var EndDate: Double?
    var WalkTime: Double?
    var WalkDistance: Double?
    var coordinateList: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    
    @IBOutlet weak var totalWalkTimeLabel: UILabel!
    @IBOutlet weak var totalWalkDistanceLabel: UILabel!
    @IBOutlet weak var walkStartDateLabel: UILabel!
    @IBOutlet weak var walkEndDateLabel: UILabel!
    @IBOutlet weak var walkStartTimeLabel: UILabel!
    @IBOutlet weak var walkEndTimeLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var walkImageView: UIImageView!
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
                
                self.StartDate = walkStartDate.timeIntervalSinceReferenceDate
            }
            
            if let walkEndDate = userInfo["walkEndDate"] as? Date {
                self.walkEndDateLabel.text = walkEndDate.monthAndDayFormatted
                self.walkEndTimeLabel.text = walkEndDate.hourAndMinuteFormatted
                
                self.EndDate = walkEndDate.timeIntervalSinceReferenceDate
            }
            
            if let totalWalkTime = userInfo["totalWalkTime"] as? Double
            {
                self.totalWalkTimeLabel.text = totalWalkTime.timerFormattedWithKoreaHourAndMin
                
                self.WalkTime = totalWalkTime
            }
            
            if let totalWalkDistance = userInfo["totalWalkDistance"] as? Double {
                self.totalWalkDistanceLabel.text = Measurement(value: totalWalkDistance / 1000, unit: UnitLength.kilometers).kilometerFormatted
                
                self.WalkDistance = totalWalkDistance
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
            
            guard let petId = KeychainWrapper.standard.integer(forKey: .apiPetId) else {
                self.presentOneButtonAlert(alertTitle: "알림", message: "펫 정보를 불러오는데 오류가 발생했습니다.", actionTitle: "확인")
                return
            }
            
            guard let familyMemberId = KeychainWrapper.standard.integer(forKey: .apiFamilyMemberId) else {
                self.presentOneButtonAlert(alertTitle: "알림", message: "유저 정보를 불러오는데 오류가 발생했습니다.", actionTitle: "확인")
                return
            }
            
            let startTime: Double = self.StartDate ?? Date().timeIntervalSinceReferenceDate
            let endTime: Double = self.EndDate ?? Date().timeIntervalSinceReferenceDate
            
            let distance: Double = self.WalkDistance ?? 0.0
            let contents: String = self.walkRecordContentsTextView.text ?? "오늘의 산책 끝!"
            
            if let image = self.walkImageView.image {
                BlobManager.shared.upload(image: image) { (returnURL) in
                    if let imageURL = returnURL {
                        // 이미지를 넣은 data
                    }
                }
            }
            
            var data: Data? = nil
            let encoder: JSONEncoder = JSONEncoder()
            
            do {
                data = try encoder.encode(WalkHistoryPostModel(
                                        petId: petId,
                                        familyMemberId: familyMemberId,
                                        startTime: startTime,
                                        endTime: endTime,
                                        distance: distance,
                                        contents: contents,
                                        fileUrl1: "",
                                        fileUrl2: "",
                                        fileUrl3: "",
                                        fileUrl4: "",
                                        fileUrl5: ""))
            } catch {
                print(error)
            }
            
            
            ApiManager.shared.fetch(urlStr: ApiManager.createWalkHistory, httpMethod: "Post", body: data) { (result: Result<SingleResponse<WalkHistoryDto>, Error>) in
                switch result {
                case .success(let responseData):
                    switch responseData.code {
                    case Statuscode.ok.rawValue:
                        guard let walkHistoryDto = responseData.data else { return }
                        
                        // Coredata저장
                        CoreDataManager.shared.createNewWalkHistory(dto: walkHistoryDto)
                        
                        // 완료메세지?(필요한가?) 및 화면 이동
                        self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
                    default:
                        print(responseData)
                        DispatchQueue.main.async {
                            self.presentOneButtonAlert(alertTitle: "알림", message: "네트워크 오류 발생", actionTitle: "확인")
                        }
                    }
                    
                case .failure(let error):
                    print(error)
               
                }
            }
            
            self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
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
