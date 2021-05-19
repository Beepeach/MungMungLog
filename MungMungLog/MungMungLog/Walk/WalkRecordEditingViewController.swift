//
//  RecodEditingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/09.
//

import UIKit

class WalkRecordEditingViewController: UIViewController {
    
    var walkRecordTime: Int = 0
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var walkRecordImageView: UIImageView!
    @IBOutlet weak var walkDateAndTimeLabel: UILabel!
    @IBOutlet weak var walkRecordTimeLabel: UILabel!
    
    
    @objc func changeWalkDateAndTimeLabel(notification: Notification) {
        guard let walkDateAndTime = notification.userInfo?["WalkDateAndTime"] as? [String],
              let walkDate = walkDateAndTime.first,
              let walkTime = walkDateAndTime.last else {
            return
        }
        
        self.walkDateAndTimeLabel.text = "\(walkDate)\n\(walkTime)"
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentTwoButtonAlert(alertTitle: "기록을 중지하시겠어요?", message: "중지하시면 현재 데이터가 삭제됩니다.", confirmActionTitle: "확인", cancelActionTitle: "취소") {_ in
            
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        print("save")
        // ToDo
        // 데이터베이스에 산책데이터를 저장하는 코드
    }
    
    
    // ToDo
    // 일단 사진 1개만 추가 가능하도록 구현.
    // 추후에 여러 사진 선택가능하도록
    @IBAction func selectPhoto(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "카메라", style: .default) {_ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                presentCamera()
            } else {
                self.presentOneButtonAlert(alertTitle: "알림",
                                           message: "카메라 사용이 불가능합니다.",
                                           actionTitle: "확인")
            }
        }
        
        let library = UIAlertAction(title: "앨범", style: .default) {_ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                presentLibrary()
            } else {
                self.presentOneButtonAlert(alertTitle: "알림",
                                           message: "앨범 사용이 불가능합니다.",
                                           actionTitle: "확인")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        func verifyUsingCamera() -> Bool {
            UIImagePickerController.isSourceTypeAvailable(.camera)
        }
        
        func presentCamera() {
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        func presentLibrary() {
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
//        if let formattedWalkingTime = timerStringFormatter.string(from: Double(walkRecordTime)) {
//            walkRecordTimeLabel.text = "산책 시간: \(formattedWalkingTime)"
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeWalkDateAndTimeLabel(notification:)), name: NSNotification.Name.DateValueDidChange, object: nil)
    }
}


extension WalkRecordEditingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        walkRecordImageView.image = image
        
        
        dismiss(animated: true, completion: nil)
    }
}
