//
//  AlertCreator.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/08/01.
//

import UIKit

class AlertCreator {
    public func createOneButtonAlert(vc viewController: UIViewController , title: String = "알림", message: String, actionTitle: String = "확인", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func createTwoButtonAlert(vc viewController: UIViewController, title: String = "알림", message: String, confirmActionTitle: String = "확인", cancelActionTitle: String = "취소", handler: ((UIAlertAction) -> Void)? = nil)  {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: confirmActionTitle, style: .destructive, handler: handler)
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelActionTitle, style: .default, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }   
}
