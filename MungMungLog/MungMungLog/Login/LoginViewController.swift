//
//  LoginViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/10.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginStackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var passwordFindingView: UIView!
    @IBOutlet weak var idInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginWithSnsStackView: UIStackView!
    
    func setContentsStartPosition() {
        loginStackViewTopConstraint.constant = (view.frame.height * 0.55)
        loginStackView.alpha = 0
        passwordFindingView.alpha = 0
        loginWithSnsStackView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentsStartPosition()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            moveLogoToTop()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                presentLoginView()
            })
            
        }
        
        func moveLogoToTop() {
            logoCenterYConstraint.constant = -(view.frame.height / 5)
        }
        
        func presentLoginView() {
            loginStackView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            loginWithSnsStackView.alpha = 1.0
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let bounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
        
            self.loginScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height, right: 0)
            
            moveScreentoFirstResponder()
        }
        
        func moveScreentoFirstResponder() {
            if self.idInputField.isFirstResponder == true || self.passwordInputField.isFirstResponder == true {
                self.loginScrollView.scrollRectToVisible(self.loginWithSnsStackView.frame, animated: true)
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            self.loginScrollView.contentInset = .zero
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}


extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        
        logoImageView.alpha = min(max(1.0 - (y / (view.frame.height / 10)), 0.0), 1.0)
    }
}
