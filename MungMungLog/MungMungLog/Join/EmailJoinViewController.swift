//
//  EmailJoinViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/02.
//

import UIKit

class EmailJoinViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    
    @IBOutlet weak var JoinButtonBottomConstraint: NSLayoutConstraint!
    
    @IBAction func joinWithEmail(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
    }
    
    
    func setScreenWhenShowKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [self] (noti) in
            guard let userInfo = noti.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            JoinButtonBottomConstraint.constant = keyboardFrame.height
            view.layoutIfNeeded()
        }
        
    }
    
    func setScreenWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [self] (_) in
            JoinButtonBottomConstraint.constant = 24
            view.layoutIfNeeded()
        }
    }

}


extension EmailJoinViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
            return true
        case passwordField:
            passwordConfirmField.becomeFirstResponder()
            return true
        case passwordConfirmField:
            passwordConfirmField.resignFirstResponder()
            return true
        default:
            return true
        }
    }
}
