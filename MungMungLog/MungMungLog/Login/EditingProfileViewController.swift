//
//  EditingProfileViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    var isMale: Bool = true
    
    @IBOutlet weak var editingProfileScrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    
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
