import UIKit


extension UIViewController {
    func presentOneButtonAlert(alertTitle: String, message: String, actionTitle: String) {
        let oneButtonAlert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        
        oneButtonAlert.addAction(alertAction)
        
        present(oneButtonAlert, animated: true, completion: nil)
    }
    
    func presentTwoButtonAlert(alertTitle: String, message: String, confirmActionTitle: String, cancelActionTitle: String) {
        let twoButtonAlert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let confirmAlertAction = UIAlertAction(title: confirmActionTitle, style: .default, handler: nil)
        let cancelAlertAction = UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil)
        
        twoButtonAlert.addAction(confirmAlertAction)
        twoButtonAlert.addAction(cancelAlertAction)
        
        present(twoButtonAlert, animated: true, completion: nil)
    }
}

