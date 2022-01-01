//
//  LoginViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/10.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import AuthenticationServices
import SwiftKeychainWrapper
import AVFAudio

class LoginViewController: UIViewController {
    // MARK: Properties
    private var isAccessibleId = false
    private var isAccessiblePassword = false
    private let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    // MARK: @IBOutlet
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
    
    // MARK: @IBAction
    @IBAction func loginWithEmail(_ sender: Any) {
        KeychainWrapper.standard.remove(forKey: .apiToken)
        
        guard let email = idInputField.text,
              let password = passwordInputField.text else {
                  return
              }
        
        var data: Data? = nil
        let encoder = JSONEncoder()
        
        do {
            data = try encoder.encode(EmailLoginRequestModel(email: email, password: password))
        } catch {
            AlertCreator().createOneButtonAlert(vc: self, message: "요청을 실패했습니다.")
            print(#function, error)
        }
        
        ApiManager.shared.fetch(urlStr: ApiManager.emailLogin, httpMethod: "Post", body: data) { (result: Result<LoginResponseModel, Error>) in
            switch result{
            case .success(let responseData):
                switch responseData.code {
                case Statuscode.ok.rawValue:
                    
                    self.saveUserDataInKeychainAndCoreData(with: responseData)
                    
                    print(#function, "=======로그인 성공========")
                    print(responseData)
                    
                    self.goToCorrectSceneForKeychain()
                    
                case Statuscode.notFound.rawValue:
                    DispatchQueue.main.async {
                        self.idInputField.becomeFirstResponder()
                        AlertCreator().createOneButtonAlert(vc: self ,message: "존재하지 않는 이메일입니다.")
                    }
                    
                case Statuscode.fail.rawValue:
                    DispatchQueue.main.async {
                        self.passwordInputField.becomeFirstResponder()
                        AlertCreator().createOneButtonAlert(vc: self, message: "비밀번호가 틀렸습니다.")
                    }
                    
                case Statuscode.tokenError.rawValue:
                    fallthrough
                    
                default:
                    DispatchQueue.main.async {
                        AlertCreator().createOneButtonAlert(vc: self, message: "로그인에 실패했습니다.")
                    }
                }
                
            case .failure(let error):
                print(#function, error)
                DispatchQueue.main.async {
                    AlertCreator().createOneButtonAlert(vc: self, message: "로그인에 실패했습니다.")
                }
            }
        }
    }
    
    func goToCorrectSceneForKeychain() {
        DispatchQueue.main.async {
            if let nickname = KeychainWrapper.standard.string(forKey: .apiNickname),
               nickname.count > 0 {
                self.checkFamilyIDKeychain()
            } else {
                self.performSegue(withIdentifier: MovetoView.membershipRegistration.rawValue, sender: nil)
            }
        }
    }
    
    private func checkFamilyIDKeychain() {
        if let _ = KeychainWrapper.standard.integer(forKey: .apiFamilyId) {
            self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
        } else {
            self.performSegue(withIdentifier: MovetoView.registrationGuide.rawValue, sender: nil)
        }
    }
    
    @IBAction func loginWithKakao(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKaKaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        setupApppleLogin()
        hideLoginContents()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.presentLoginView()
            }
        }
        
        configureScreenWhenKeyboardAppear { bounds in
            self.loginScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bounds.height, right: 0)
            self.moveScreenToFirstResponder()
        }
        configureScreenWhenKeyboardHide {
            self.loginScrollView.contentInset = .zero
        }
    }
    
    private func setupApppleLogin() {
        let appleLoginButton = ASAuthorizationAppleIDButton()
        appleLoginButton.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        loginWithSnsStackView.addArrangedSubview(appleLoginButton)
    }
    
    @objc private func handleAppleLogin() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authenticationController = ASAuthorizationController(authorizationRequests: [request])
        
        authenticationController.delegate = self
        authenticationController.presentationContextProvider = self
        authenticationController.performRequests()
    }
    
    private func hideLoginContents() {
        loginContainerView.alpha = 0
        passwordFindingView.alpha = 0
        loginWithSnsStackView.alpha = 0
        
        incorrectIdFormatLabel.alpha = 0
        incorrectPasswordFormatLabel.alpha = 0
    }
    
    private func presentLoginView() {
        loginContainerView.alpha = 1.0
        passwordFindingView.alpha = 1.0
        loginWithSnsStackView.alpha = 1.0
    }
    
    private func moveScreenToFirstResponder() {
        if self.idInputField.isFirstResponder == true || self.passwordInputField.isFirstResponder == true {
            self.loginScrollView.scrollRectToVisible(self.loginWithSnsStackView.frame  , animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}


// MARK: - UIScrollViewDelegate
extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        
        logoImageView.alpha = min(max(1.0 - (y / (view.frame.height / 10)), 0.0), 1.0)
    }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case idInputField:
            if idInputField.text?.count != 0 {
                passwordInputField.becomeFirstResponder()
            } else {
                idInputField.becomeFirstResponder()
                AlertCreator().createOneButtonAlert(vc: self, message: "아이디를 입력해주세요.")
            }
            
        case passwordInputField:
            if passwordInputField.text?.count != 0 {
                self.view.endEditing(true)
            } else {
                passwordInputField.becomeFirstResponder()
                AlertCreator().createOneButtonAlert(vc: self, message: "비밀번호를 입력해주세요.")
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
            if string == " " {
                return false
            }
            
            guard let range = finalText.range(of: emailRegEx, options: .regularExpression),
                  range.lowerBound == finalText.startIndex && range.upperBound == finalText.endIndex else {
                      checkID(isValid: false, alpha: finalText.isEmpty ? 0.0 : 1.0)
                      return true
                  }
            
            checkID(isValid: true, alpha: 0.0)
            
        case passwordInputField:
            guard finalText.count >= 4,
                  finalText.count <= 20 else {
                      checkPassword(isValid: false, alpha: finalText.isEmpty ? 0.0 : 1.0)
                      return true
                  }
            
            checkPassword(isValid: true, alpha: 0.0)
            
        default:
            return true
        }
        
        return true
    }
    
    private func checkID(isValid: Bool, alpha: CGFloat) {
        isAccessibleId = isValid
        incorrectIdFormatLabel.alpha = alpha
        activateLoginButton()
    }
    
    private func checkPassword(isValid: Bool, alpha: CGFloat) {
        isAccessiblePassword = isValid
        incorrectPasswordFormatLabel.alpha = alpha
        activateLoginButton()
    }
    
    private func activateLoginButton() {
        if isAccessibleId == true && isAccessiblePassword == true {
            loginButtonContainerView.isUserInteractionEnabled = true
            loginButtonContainerView.backgroundColor = .systemTeal
        } else {
            loginButtonContainerView.isUserInteractionEnabled = false
            loginButtonContainerView.backgroundColor = .systemGray4
        }
    }
}
