//
//  MembershipRegistrationViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/16.
//

import UIKit

class MembershipRegistrationViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var nicknameContainerView: UIView!
    @IBOutlet weak var relationshipContainerView: UIView!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var photoContainerView: UIView!
    
    @IBOutlet weak var continueFlotingView: RoundedView!
    
    func setContentsStartPosition() {
        welcomeTextTopConstraint.constant = (view.frame.height / 2) - (welcomeTextLabel.bounds.height / 2)
        
        nicknameContainerView.alpha = 0.0
        relationshipContainerView.alpha = 0.0
        genderContainerView.alpha = 0.0
        photoContainerView.alpha = 0.0
        continueFlotingView.alpha = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentsStartPosition()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            moveWelcomeTextToTop()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.view.layoutIfNeeded()
                
            } completion: { (finished) in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    presentContents()
                }
            }
            
        }
        
        func moveWelcomeTextToTop() {
            welcomeTextTopConstraint.constant = 72
        }
        
        func presentContents() {
            nicknameContainerView.alpha = 1.0
            relationshipContainerView.alpha = 1.0
            genderContainerView.alpha = 1.0
            photoContainerView.alpha = 1.0
            continueFlotingView.alpha = 1.0
        }
        
    }
    
}
