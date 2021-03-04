//
//  LoginViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/10.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginContainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var incorrectIdFormatLabel: UILabel!
    @IBOutlet weak var idInputField: UITextField!
    @IBOutlet weak var incorrectPasswordFormatLabel: UILabel!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButtonContainerView: RoundedView!
    @IBOutlet weak var passwordFindingView: UIView!
    @IBOutlet weak var loginWithSnsStackView: UIStackView!
    
    var isAccessibleLoginId = false
    var isAccessibleLoginPassword = false
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    func setContentsStartPosition() {
        loginContainerViewTopConstraint.constant = (view.frame.height * 0.55)
        loginContainerView.alpha = 0
        passwordFindingView.alpha = 0
        loginWithSnsStackView.alpha = 0
        incorrectIdFormatLabel.alpha = 0
        incorrectPasswordFormatLabel.alpha = 0
    }
    
    func setScreenWhenShowKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let bounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            self.loginScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height, right: 0)
            
            self.moveScreentoFirstResponder()
        }
    }
    
    func moveScreentoFirstResponder() {
        if self.idInputField.isFirstResponder == true || self.passwordInputField.isFirstResponder == true {
            self.loginScrollView.scrollRectToVisible(self.loginWithSnsStackView.frame  , animated: true)
        }
    }
    
    func setScreenWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            self.loginScrollView.contentInset = .zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            
        }

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
            loginContainerView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            loginWithSnsStackView.alpha = 1.0
        }

        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}


extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        
        logoImageView.alpha = min(max(1.0 - (y / (view.frame.height / 10)), 0.0), 1.0)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idInputField:
            if idInputField.text?.count != 0 {
                passwordInputField.becomeFirstResponder()
            } else {
                idInputField.becomeFirstResponder()
                presentOneButtonAlert(alertTitle: "알림", message: "아이디를 입력해주세요.", actionTitle: "확인")
            }
            
        case passwordInputField:
            if passwordInputField.text?.count != 0 {
                self.view.endEditing(true)
            } else {
                passwordInputField.becomeFirstResponder()
                presentOneButtonAlert(alertTitle: "알림", message: "비밀번호를 입력해주세요.", actionTitle: "확인") 
            }
            
        default:
            view.endEditing(true)
        }
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text as NSString? else {
            return true
        }
        
        let finalText = currentText.replacingCharacters(in: range, with: string)
  
        switch textField {
        case idInputField:
            guard let range = finalText.range(of: emailRegEx,
                                              options: .regularExpression),
                  range.lowerBound == finalText.startIndex && range.upperBound == finalText.endIndex else {
                isAccessibleLoginId = false
                incorrectIdFormatLabel.alpha = 1
                checkLoginButtonEnable()
                return true
            }
            
            isAccessibleLoginId = true
            incorrectIdFormatLabel.alpha = 0
            checkLoginButtonEnable()
            return true
            
        case passwordInputField:
            guard finalText.count >= 4,
                  finalText.count <= 20 else {
                isAccessibleLoginPassword = false
                incorrectPasswordFormatLabel.alpha = 1
                checkLoginButtonEnable()
                return true
            }
            
            isAccessibleLoginPassword = true
            incorrectPasswordFormatLabel.alpha = 0
            checkLoginButtonEnable()
            return true
            
        default:
            return true
        }
        
    }
    
    func checkLoginButtonEnable() {
        if isAccessibleLoginId == true && isAccessibleLoginPassword == true {
            loginButtonContainerView.isUserInteractionEnabled = true
            loginButtonContainerView.backgroundColor = .systemTeal
        } else {
            loginButtonContainerView.isUserInteractionEnabled = false
            if #available(iOS 13.0, *) {
                loginButtonContainerView.backgroundColor = .systemGray4
            } else {
                loginButtonContainerView.backgroundColor = .lightGray
            }
        }
    }
    
}
