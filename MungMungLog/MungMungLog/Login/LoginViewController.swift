//
//  LoginViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/10.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var passwordFindingView: UIView!
    
    var logoImageViewOrigin: CGPoint {
        get {
            return logoImageView.frame.origin
        } set {
            logoImageView.frame.origin = newValue
        }
    }
    
    override func viewDidLayoutSubviews() {


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginStackView.alpha = 0
        passwordFindingView.alpha = 0

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                moveLogoToTop()
                presentLoginView()
            })
        }
        
        func moveLogoToTop() {
            let logoFrame = logoImageView.frame
            let logoCenterXPosition = view.center.x - (logoFrame.width / 2)
            let logoCenterYPosition = view.center.y - (logoFrame.height / 2)
            
            logoImageViewOrigin = CGPoint(x: logoCenterXPosition,
                                          y: logoCenterYPosition - (view.frame.height / 5))
        }
        
        func presentLoginView() {
            loginStackView.alpha = 1.0
            passwordFindingView.alpha = 1.0
        }
    }
    
}
