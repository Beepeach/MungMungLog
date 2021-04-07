//
//  EmailJoinViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/02.
//

import UIKit
import SwiftKeychainWrapper

class EmailJoinViewController: UIViewController {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinWithEmail(_ sender: Any) {
        guard let email = emailField.text,
              email.count > 0 else {
            emailField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "이메일을 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let range = emailField.text?.range(of: emailRegEx,
                                                 options: .regularExpression),
              range.lowerBound == emailField.text?.startIndex && range.upperBound == emailField.text?.endIndex else {
            emailField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "올바른 이메일을 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let password = passwordField.text,
              (4...20).contains(password.count) else {
            passwordField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "비밀번호는 4 ~ 20 자로 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let passwordConfirm = passwordConfirmField.text,
              password == passwordConfirm
        else {
            passwordConfirmField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "비밀번호가 일치하지 않습니다.", actionTitle: "확인")
            return
        }
        
        KeychainWrapper.standard.remove(forKey: "api-token")
        
        guard let url = URL(string: ApiManager.emailJoin) else {
            print(ApiError.invalidURL)
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(EmailJoinRequestModel(email: email, password: password))
        } catch {
            print(error)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error  {
                print(error)
                return
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
                
                let responseData = try decoder.decode(
                    JoinResponseModel.self, from: data)
                
                switch responseData.code {
                case Statuscode.ok.rawValue:
                    if let token = responseData.token {
                        KeychainWrapper.standard.set(token, forKey: "api-token")
                    }
                    
                    if let userId = responseData.userId {
                        KeychainWrapper.standard.set(userId, forKey: "api-userId")
                    }
                    
                    if let email = responseData.email {
                        KeychainWrapper.standard.set(email, forKey: "api-email")
                    }
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: MovetoView.membershipRegistration.rawValue, sender: nil)
                        print("회원 가입에 성공했습니다.")
                    }
                    
                case Statuscode.fail.rawValue:
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "토큰 생성에 실패했습니다.", actionTitle: "확인")
                    }
                    print(responseData)
                    
                case Statuscode.failWithDuplication.rawValue:
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "존재하는 이메일 계정입니다.", actionTitle: "확인")
                    }
                    print(responseData)
                    
                case Statuscode.unKnown.rawValue:
                    fallthrough
                    
                default :
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "유저 생성에 실패했습니다.", actionTitle: "확인")
                    }
                    print(responseData)
                }
                
                // 존재하는 계정이라면 존재하는 계정입니다 라는
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            joinWithEmail(self)
            return true
        default:
            return true
        }
    }
    
    
}
