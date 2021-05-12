//
//  RecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/28.
//

import UIKit
import SwiftKeychainWrapper

class WalkRecordStartingViewController: UIViewController {
   
    @IBAction func startWalkRecord(_ sender: Any) {
        if let _ = KeychainWrapper.standard.string(forKey: .apiFamilyId) {
            performSegue(withIdentifier: MovetoView.walkRecode.rawValue, sender: nil)
        } else {
            presentOneButtonAlert(alertTitle: "알림", message: "반려견을 등록해주세요.", actionTitle: "확인")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
