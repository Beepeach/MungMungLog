//
//  QnaViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/27.
//

import UIKit

class QnaViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var contentsTextView: UITextView!
    
    
    @IBAction func backMyPageVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: Any) {
        presentOneButtonAlert(alertTitle: "알림", message: "문의하신 내용이 잘 전달되었습니다.", actionTitle: "확인") { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}


extension QnaViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
}
