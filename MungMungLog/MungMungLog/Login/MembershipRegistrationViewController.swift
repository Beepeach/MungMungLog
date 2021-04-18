//
//  MembershipRegistrationViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/16.
//

import UIKit
import SwiftKeychainWrapper

class MembershipRegistrationViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    var userIsMale: Bool?
    
    @IBOutlet weak var welcomeTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var membershipRegistrationScrollView: UIScrollView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nicknameContainerView: UIView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var relationshipContainerView: UIView!
    @IBOutlet weak var relationshipField: UITextField!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var membershipImageView: UIImageView!
    @IBOutlet weak var membershipImageAddbutton: UIButton!
    @IBOutlet weak var continueContainerView: RoundedView!
    
    
    @IBAction func logout(_ sender: Any) {
        KeychainWrapper.standard.remove(forKey: .apiToken)
        KeychainWrapper.standard.remove(forKey: .apiUserId)
        KeychainWrapper.standard.remove(forKey: .apiEmail)
        performSegue(withIdentifier: MovetoView.login.rawValue, sender: nil)
    }
    
    @IBAction func selectMale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            maleContainerView.backgroundColor = .systemGray4
        } else {
            maleContainerView.backgroundColor = .lightGray
        }
        femaleContainerView.backgroundColor = .none
        userIsMale = true
    }
    
    @IBAction func selectFemale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            femaleContainerView.backgroundColor = .systemGray4
        } else {
            femaleContainerView.backgroundColor = .lightGray
        }
        maleContainerView.backgroundColor = .none
        userIsMale = false
    }
    
    func setContentsStartPosition() {
        welcomeTextTopConstraint.constant = (view.frame.height / 2) - (welcomeTextLabel.bounds.height / 2)
        navigationController?.setNavigationBarHidden(true, animated: true)
        emailContainerView.alpha = 0.0
        nicknameContainerView.alpha = 0.0
        relationshipContainerView.alpha = 0.0
        genderContainerView.alpha = 0.0
        photoContainerView.alpha = 0.0
        continueContainerView.alpha = 0.0
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "프로필 사진을 골라주세요.", message: "어디서 가져올까요??", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "앨범", style: .default) { [self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                openLibrary()
            } else {
                presentOneButtonAlert(alertTitle: "알림", message: "앨범 사용이 불가능합니다.", actionTitle: "확인")
            }
        }
        
        func openLibrary() {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: false, completion: nil)
        }
        
        let camera = UIAlertAction(title: "카메라", style: .default) { [self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                openCamera()
            } else {
                presentOneButtonAlert(alertTitle: "알림", message: "카메라 사용이 불가능합니다.", actionTitle: "확인")
            }
        }
        
        func openCamera() {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func RegisterUserInfo(_ sender: Any) {
        guard let email = emailField.text else {
            
            presentOneButtonAlert(alertTitle: "알림", message: "잘못된 이메일 회원정보입니다.\n로그인화면으로 돌아갑니다.", actionTitle: "확인") { (_) in
                self.performSegue(withIdentifier: MovetoView.login.rawValue, sender: nil)
            }
            return
        }
        
        guard let nickname = nicknameField.text, nickname.count > 0 else {
            nicknameField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "올바른 닉네임을 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let relationship = relationshipField.text, relationship.count > 0 else {
            relationshipField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "올바른 관계를 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let gender = userIsMale else {
            presentOneButtonAlert(alertTitle: "알림", message: "성별을 선택해주세요.", actionTitle: "확인")
            return
        }
        
        guard let url = URL(string: ApiManager.joinWithInfo) else {
            print(ApiError.invalidURL)
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            var imageUrl: String?
            
            if let img = membershipImageView.image {
                BlobManager.shared.upload(image: img) { (reutrnUrl) in
                    if let returnUrl = reutrnUrl {
                        imageUrl = returnUrl
                    }
                }
            }
            
            let encoder = JSONEncoder()
            let requestModel = JoinInfoRequestModel(email: email, nickname: nickname, relationship: relationship, gender: gender, fileUrl: imageUrl ?? "")
            request.httpBody = try encoder.encode(requestModel)
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
                let responseData = try decoder.decode(JoinResponseModel.self, from: data)
                
                if responseData.code == Statuscode.ok.rawValue {
                    if let nickname = responseData.nickname {
                        KeychainWrapper.standard.set(nickname, forKey: KeychainWrapper.Key.apiNickname.rawValue)
                    }
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: MovetoView.registrationGuide.rawValue, sender: nil)
                    }
                    print(responseData)
                } else {
                    print("회원정보입력 실패")
                    print(responseData)
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
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
            navigationController?.setNavigationBarHidden(false, animated: true)
            emailContainerView.alpha = 1.0
            nicknameContainerView.alpha = 1.0
            relationshipContainerView.alpha = 1.0
            genderContainerView.alpha = 1.0
            photoContainerView.alpha = 1.0
            continueContainerView.alpha = 1.0
        }
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
        
        imagePicker.delegate = self
        
        emailField.text = KeychainWrapper.standard.string(forKey: .apiEmail) ?? "Unknown"
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


extension MembershipRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        membershipImageView.image = image
        
        if membershipImageView.image != nil {
            let moreImage = UIImage(named: "more")
            
            membershipImageAddbutton.alpha = 0.4
            membershipImageAddbutton.setImage(moreImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
