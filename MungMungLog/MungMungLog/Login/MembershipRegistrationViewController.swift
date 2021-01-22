//
//  MembershipRegistrationViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/16.
//

import UIKit

class MembershipRegistrationViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var membershipRegistrationScrollView: UIScrollView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var nicknameContainerView: UIView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var relationshipContainerView: UIView!
    @IBOutlet weak var relationshipField: UITextField!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var photoContainerView: UIView!
    
    @IBOutlet weak var continueContainerView: RoundedView!
    
    func setContentsStartPosition() {
        welcomeTextTopConstraint.constant = (view.frame.height / 2) - (welcomeTextLabel.bounds.height / 2)
        
        nicknameContainerView.alpha = 0.0
        relationshipContainerView.alpha = 0.0
        genderContainerView.alpha = 0.0
        photoContainerView.alpha = 0.0
        continueContainerView.alpha = 0.0
    }
    
    func setScreenWhenShowKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let bounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            self.membershipRegistrationScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height, right: 0)
        }
    }
    
    func setScreenWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            
            self.membershipRegistrationScrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentsStartPosition()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            moveWelcomeTextToTop()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.view.layoutIfNeeded()
                
            } completion: { (finished) in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    presentContents()
                }
            }
            
        }
        
        func moveWelcomeTextToTop() {
            welcomeTextTopConstraint.constant = 72
        }
        
        func presentContents() {
            nicknameContainerView.alpha = 1.0
            relationshipContainerView.alpha = 1.0
            genderContainerView.alpha = 1.0
            photoContainerView.alpha = 1.0
            continueContainerView.alpha = 1.0
        }
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
    }
    
}


extension MembershipRegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nicknameField:
            if nicknameField.text?.count != 0 {
                relationshipField.becomeFirstResponder()
            } else {
                nicknameField.becomeFirstResponder()
                presentOneButtonAlert(alertTitle: "알림", message: "닉네임을 입력해주세요.", actionTitle: "확인")
            }
            
        case relationshipField:
            if relationshipField.text?.count != 0 {
                view.endEditing(true)
            } else {
                presentOneButtonAlert(alertTitle: "알림", message: "반려견과의 관계를 입력해주세요.", actionTitle: "확인")
            }
            
        default:
            view.endEditing(true)
        }
        
        return true
    }
}
