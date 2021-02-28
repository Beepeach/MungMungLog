//
//  CodeInputViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/02/28.
//

import UIKit

class CodeInputViewController: UIViewController {
    
    @IBOutlet weak var continueContainerViewBottomCostraint: NSLayoutConstraint!
    
    @IBOutlet weak var ContinueContainerView: RoundedView!
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterCode(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonWhenShowKeyboard()
        setButtonWhenHideKeyboard()
    }
    
    func setButtonWhenShowKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            guard let userInfo = noti.userInfo else { return }
            
            guard let keyboardBound = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.continueContainerViewBottomCostraint.constant = keyboardBound.height + 10
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                self.view.layoutIfNeeded()
            }
        }
    }
    

    func setButtonWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            self.continueContainerViewBottomCostraint.constant = 36
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                self.view.layoutIfNeeded()
            }
        }
    }
}



