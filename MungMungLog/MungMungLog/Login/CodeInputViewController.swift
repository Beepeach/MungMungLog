//
//  CodeInputViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/02/28.
//

import UIKit
import SwiftKeychainWrapper

class CodeInputViewController: UIViewController {
    
    @IBOutlet weak var continueContainerViewBottomCostraint: NSLayoutConstraint!
    
    @IBOutlet weak var ContinueContainerView: RoundedView!
    
    @IBOutlet weak var codeField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterCode(_ sender: Any) {
        guard let code = codeField.text,
              code.count == 8 else {
            codeField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "8자리 코드를 입력해주세요,", actionTitle: "확인")
            return
        }
        
        guard let email = KeychainWrapper.standard.string(forKey: .apiEmail) else {
            presentOneButtonAlert(alertTitle: "알림", message: "계정 이메일에 문제가 발생했습니다.\n다시 로그인 후 시도해주세요.", actionTitle: "확인")
            return
        }
        
        guard let url = URL(string: ApiManager.requestInvitation) else {
            print(#function, ApiError.invalidURL)
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(InvitationCodeRequestModel(code: code, email: email))
        } catch {
            print(error.localizedDescription)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(#function, error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print(#function, ApiError.failed(999))
                return
            }
            
            guard let data = data else {
                print(#function, ApiError.emptyData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(SingleResponse<FamilyDto>.self, from: data)
                
                switch responseData.code {
                case Statuscode.ok.rawValue:
                    guard let pet = responseData.data?.pets.first else {
                        return
                    }
                    
                    KeychainWrapper.standard.set(pet.familyId, forKey: KeychainWrapper.Key.apiFamilyId.rawValue)
                    
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "\(pet.name)네 가족에 초대 신청을 보냈습니다.\n구성원장이 수락해야 초대가 완료됩니다.", actionTitle: "확인") { (_) in
                            self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "초대코드를 보내는데 실패했습니다.", actionTitle: "확인")
                    }
                }
            } catch {
                print(#function, error)
            }
            
            
        }
        
        task.resume()
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


extension CodeInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enterCode(self)
        return true
    }
}

