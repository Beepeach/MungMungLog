import UIKit


extension UIViewController {
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

