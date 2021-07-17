//
//  EditingProfileViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit
import SwiftKeychainWrapper

class EditingProfileViewController: UIViewController {
    
    //MARK: - Properties
    let imagePicker = UIImagePickerController()
    
    var isMale: Bool?
    
    // MARK: - @IBOutlet
    @IBOutlet var birthdayPickerContainerView: UIView!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet var breedsContainerView: UIView!
    @IBOutlet weak var breedsPickerView: UIPickerView!
    @IBOutlet var doneAccessoryBar: UIToolbar!
    
    @IBOutlet weak var editingProfileScrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petImageAddButton: UIButton!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        maleContainerView.backgroundColor = .none
        femaleContainerView.backgroundColor = .none
        
        setScreenWhenShowKeyboard()
        setScreenWhenHideKeyboard()
        
        birthdayField.inputView = birthdayPickerContainerView
        birthdayField.inputAccessoryView = doneAccessoryBar
        birthdayField.tintColor = .clear
        birthdayDatePicker.maximumDate = Date()
        birthdayDatePicker.minimumDate = Date(timeIntervalSince1970: 0)
        
        breedField.inputView = breedsContainerView
        breedField.inputAccessoryView = doneAccessoryBar
        breedField.tintColor = .clear
    }
    
    private func setScreenWhenShowKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [self] (noti) in
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let keyboardBounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            editingProfileScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardBounds.height, right: 0)
        }
    }
    
    private func setScreenWhenHideKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [self] (_) in
            editingProfileScrollView.contentInset = .zero
        }
    }
    
    // MARK: - @IBAction
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
    
    @IBAction func selectBirthdayOrBreeds(_ sender: Any) {
        if birthdayField.isFirstResponder {
            birthdayField.text = birthdayDatePicker.date.koreanDateFormatted
            birthdayField.resignFirstResponder()
        } else if breedField.isFirstResponder {
            breedField.text = breeds[breedsPickerView.selectedRow(inComponent: 0)]
            breedField.resignFirstResponder()
        }
        
    }
    
    // TODO: - 중복되는 코드이므로 줄일 방법 생각해보기
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
    
    @IBAction func createPet(_ sender: Any) {
        guard let email = KeychainWrapper.standard.string(forKey: .apiEmail) else {
            KeychainWrapper.standard.remove(forKey: .apiToken)
            KeychainWrapper.standard.remove(forKey: .apiUserId)
            KeychainWrapper.standard.remove(forKey: .apiEmail)
            
            presentOneButtonAlert(alertTitle: "알림", message: "생성 중 오류가 발생했습니다.\n로그인 화면으로 이동합니다.", actionTitle: "확인") { [self] (_) in
                DispatchQueue.main.async {
                    performSegue(withIdentifier: MovetoView.login.rawValue, sender: nil)
                }
            }
            return
        }
        
        guard let name = nameField.text,
              name.count > 0 else {
            nameField.becomeFirstResponder()
            presentOneButtonAlert(alertTitle: "알림", message: "반려견의 이름을 입력해주세요.", actionTitle: "확인")
            return
        }
        
        guard let gender = isMale else {
            presentOneButtonAlert(alertTitle: "알림", message: "\(name) 성별을 선택해주세요.", actionTitle: "확인")
            return
        }
        
        guard let birthdayStr = birthdayField.text,
              birthdayStr.count > 0 else {
            presentOneButtonAlert(alertTitle: "알림", message: "\(name) 생일을 선택해주세요.", actionTitle: "확인")
            return
        }
        
        guard let breed = breedField.text,
              breed.count > 0 else {
            presentOneButtonAlert(alertTitle: "알림", message: "\(name) 견종을 선택해주세요.", actionTitle: "확인")
            return
        }
        
        let baseDate = Date(timeIntervalSinceReferenceDate: 0)
        let birthdayInterval = DateInterval(start: baseDate, end: birthdayDatePicker.date).duration
        
        if let img = petImageView.image {
            requestToCreatePetWithImage(email: email, name: name, birthdayInterval: birthdayInterval, breed: breed, gender: gender, img: img)
        } else {
            requestCreatePet(email: email, name: name, birthdayInterval: birthdayInterval, breed: breed, gender: gender)
        }
    }
    
    func requestCreatePet(email: String, name: String, birthdayInterval: Double, breed: String, gender: Bool, fileUrl: String? = nil) {
        
        var data: Data? = nil
        
        do {
            let encoder = JSONEncoder()
            
           data = try encoder.encode(PetPostModel(
                                                    email: email,
                                                    name: name,
                                                    birthday: birthdayInterval,
                                                    breed: breed,
                                                    gender: gender,
                                                    fileUrl: fileUrl))
        } catch {
            print(error.localizedDescription)
        }
        
        ApiManager.shared.fetch(urlStr: ApiManager.createPet, httpMethod: "Post", body: data) { (result: Result<SingleResponse<PetDto>, Error>) in
            switch result {
            case .success(let responseData):
                switch responseData.code {
                case Statuscode.ok.rawValue:
                    guard let petDTO = responseData.data else {
                        return
                    }
                    
                    if let familyId = responseData.data?.familyId,
                       let petId = responseData.data?.petId {
                        KeychainWrapper.standard.set(familyId, forKey: KeychainWrapper.Key.apiFamilyId.rawValue)
                        KeychainWrapper.standard.set(petId, forKey: KeychainWrapper.Key.apiPetId.rawValue)
                        
                        CoreDataManager.shared.createNewPet(dto: petDTO)
                    }
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: MovetoView.home.rawValue, sender: nil)
                    }
                    print(responseData)
                    
                default:
                    print(responseData)
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "네트워크 오류 발생", actionTitle: "확인")
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestToCreatePetWithImage(email: String, name: String, birthdayInterval: Double, breed: String, gender: Bool, img: UIImage) {
        BlobManager.shared.upload(image: img) { (reutrnUrl) in
            if let imageUrl = reutrnUrl {
                self.requestCreatePet(email: email, name: name, birthdayInterval: birthdayInterval, breed: breed, gender: gender, fileUrl: imageUrl)
            }
        }
    }
    
    // InputView의 height를 정할수는 없을까??
    //    func specifyInputViewSize(_ view: UIView) {
    //        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (noti) in
    //            guard let userInfo = noti.userInfo else {
    //                return
    //            }
    //
    //            guard let keyboardBounds = userInfo[UIResponder.keyboardDidChangeFrameNotification] as? CGRect else {
    //                return
    //            }
    //        }
    //    }
}


// MARK: - UITextFieldDelegate
extension EditingProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case birthdayField:
            return false
        case breedField:
            return false
        default:
            return true
        }
    }
}


// MARK: - UIImagePickerControllerDelegate
extension EditingProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        petImageView.image = image
        
        if petImageView.image != nil {
            let moreImage = UIImage(named: "more")
            petImageAddButton.alpha = 0.4
            petImageAddButton.setImage(moreImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource
extension EditingProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
}

// MARK: - UIPickerViewDelegate
extension EditingProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
}
