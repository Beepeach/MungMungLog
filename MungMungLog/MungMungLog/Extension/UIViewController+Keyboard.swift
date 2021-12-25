//
//  UIViewController+Keyboard.swift
//  MungMungLog
//
//  Created by JunHeeJo on 12/25/21.
//

import Foundation
import UIKit

extension UIViewController {
    func configureScreenWhenKeyboardAppear(_ completion: @escaping (_ bounds: CGRect) -> ()) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            guard let userInfo = noti.userInfo else {
                return
            }
            
            guard let bounds = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            
            completion(bounds)
        }
    }
    
    func configureScreenWhenKeyboardHide(_ completion: @escaping () -> ()) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            completion()
        }
    }
}
