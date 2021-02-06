//
//  MembershipRegistrationViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/16.
//

import UIKit

class MembershipRegistrationViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    var userIsMale: Bool = true
    
    @IBOutlet weak var welcomeTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var membershipRegistrationScrollView: UIScrollView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
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
        
        imagePicker.delegate = self
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
        membershipImageAddbutton.alpha = 0.4
        dismiss(animated: true, completion: nil)
    }
}
