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

class LoginViewController: UIViewController {
    
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
    
    func login(model: SNSLoginRequestModel) {
        KeychainWrapper.standard.remove(forKey: "api-token")
        
        guard let url = URL(string: ApiManager.snsLogin) else {
            print(ApiError.invalidURL)
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(model)
        } catch {
            print(error)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                print(ApiError.emptyData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(LoginResponseModel.self, from: data)
                
                if responseData.code == Statuscode.ok.rawValue {
                    //                    dump(responseData)
                    
                    if let token = responseData.token {
                        KeychainWrapper.standard.set(token, forKey: "api-token")
                    }
                    
                    if let userId = responseData.userId {
                        KeychainWrapper.standard.set(userId, forKey: "api-userId")
                    }
                    
                    if let email = responseData.email {
                        KeychainWrapper.standard.set(email, forKey: "api-email")
                    }
                    
                    print("=======로그인 성공========")
                    print(responseData)
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: MovetoView.membershipRegistration.rawValue, sender: nil)
                    }
               
                    
                } else {
                    print("========로그인실패===========")
                    print(responseData)
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    @IBAction func loginWithKakao(_ sender: Any) {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                
                print("loginWithKakaoTalk() success.")
                self.getUserInfoFromKakao()
            }
        } else { UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            
            print("loginWithKakaoAccount() success.")
            self.getUserInfoFromKakao()
        }
        }
    }
    
    func getUserInfoFromKakao() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            }
            
            guard let id = user?.id else { return }
            
            // 카카오 email을 받을수 있을때부터는 UUID로 변경
            let email = user?.kakaoAccount?.email ?? "Test100@test.com" //"\(UUID().uuidString)@empty.com"
            
            self.requestKaKaoLogin(id: id, email: email)
        }
    }
    
    func requestKaKaoLogin(id: Int64, email: String) {
        let model = SNSLoginRequestModel(provider: "Kakao", id: "\(id)", email: email)
        
        self.login(model: model)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            
        }
        
        setContentsStartPosition()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                presentLoginView()
            }
        }
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
        
        func presentLoginView() {
            loginContainerView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            passwordFindingView.alpha = 1.0
            loginWithSnsStackView.alpha = 1.0
        }
        
        if #available(iOS 13.0, *) {
            setupAppple()
        } else {
            
        }
        
        
    }
    
    @available(iOS 13.0, *)
    func setupAppple() {
        let appleLoginButton = ASAuthorizationAppleIDButton()
        appleLoginButton.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        loginWithSnsStackView.addArrangedSubview(appleLoginButton)
    }
    
    @available(iOS 13.0, *)
    @objc func handleAppleLogin() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authenticationController = ASAuthorizationController(authorizationRequests: [request])
        
        authenticationController.delegate = self
        authenticationController.presentationContextProvider = self
        authenticationController.performRequests()
    }
    
    func setContentsStartPosition() {
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


@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("==============, \(error.localizedDescription)")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIdCredential.user
            
            // email과 name은 첫번째 이후부터 nil을 주므로 따로 저장하는게 좋지만 name은 사용하지 않으므로 저장하지 않았다.
            var email = appleIdCredential.email
            
            if let savedEmail = KeychainWrapper.standard.string(forKey: "AppleUser-Email") {
                email = savedEmail
            } else {
                if let email = email {
                    KeychainWrapper.standard.set(email, forKey: "AppleUser-Email")
                }
            }
            
            let appleLoginModel = SNSLoginRequestModel(provider: "Apple", id: userId, email: email ?? "")
            
            self.login(model: appleLoginModel)
        } else {
            presentOneButtonAlert(alertTitle: "실패", message: "Apple 인증서 오류", actionTitle: "확인")
        }
    }
}


@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}
