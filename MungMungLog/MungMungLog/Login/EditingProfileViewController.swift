//
//  EditingProfileViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    var isMale: Bool = true
    
    @IBOutlet weak var editingProfileScrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petImageAddButton: UIButton!
    
    @IBAction func cancelEditing(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectMale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            maleContainerView.backgroundColor = .systemGray4
        } else {
            maleContainerView.backgroundColor = .lightGray
        }
        femaleContainerView.backgroundColor = .none
        isMale = true
    }
    
    @IBAction func selectFemale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            femaleContainerView.backgroundColor = .systemGray4
        } else {
            femaleContainerView.backgroundColor = UIColor.lightGray
        }
        maleContainerView.backgroundColor = .none
        isMale = false
    }
    
    // ToDo: 중복되는 코드이므로 줄일 방법 생각해보기
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
            present(imagePicker, animated: false, completion: nil)
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
            
            guard let keyboardBounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            self.editingProfileScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardBounds.height, right: 0)
        }
    }
    
    func setScreenWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            self.editingProfileScrollView.contentInset = .zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        maleContainerView.backgroundColor = .none
        femaleContainerView.backgroundColor = .none
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
        
    }
    
}


extension EditingProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            
        }
        
        
        
        return true
    }
}


extension EditingProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        petImageView.image = image
        petImageAddButton.alpha = 0.4
        dismiss(animated: true, completion: nil)
    }
}
