//
//  LoginViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/10.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var passwordFindingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginStackView.alpha = 0
        passwordFindingView.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            moveLogoToTop()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
                presentLoginView()
            })
        }
        
        func moveLogoToTop() {
            self.logoCenterYConstraint.constant = -(self.view.frame.height / 5)
        }
        
        func presentLoginView() {
            self.loginStackView.alpha = 1.0
            self.passwordFindingView.alpha = 1.0
        }
        
    }
    
}
