import UIKit


extension UIViewController {
    func presentOneButtonAlert(alertTitle: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let oneButtonAlert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        
        oneButtonAlert.addAction(alertAction)
        
        present(oneButtonAlert, animated: true, completion: nil)
    }
    
    func presentTwoButtonAlert(alertTitle: String, message: String, confirmActionTitle: String, cancelActionTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let twoButtonAlert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let confirmAlertAction = UIAlertAction(title: confirmActionTitle, style: .destructive, handler: handler)
        let cancelAlertAction = UIAlertAction(title: cancelActionTitle, style: .default, handler: nil)
    
        twoButtonAlert.addAction(confirmAlertAction)
        twoButtonAlert.addAction(cancelAlertAction)
    
        present(twoButtonAlert, animated: true, completion: nil)
    }
}

