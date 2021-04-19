//
//  LauchScreenViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/07.
//

import UIKit
import SwiftKeychainWrapper

class IntroViewController: UIViewController {
    
    @IBOutlet weak var logoImageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let logoCenterYAnchor = logoImageVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        logoCenterYAnchor.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let _ = KeychainWrapper.standard.string(forKey: .apiToken),
               let _ = KeychainWrapper.standard.string(forKey: .apiUserId) {
                
                if let nickname = KeychainWrapper.standard.string(forKey: .apiNickname),
                   nickname.count > 0 {
                    checkNeededRegistrationAndChageView()

                } else {
                    chageView(to: MovetoView.membershipRegistration.rawValue)
                }
            } else {
                
                logoCenterYAnchor.isActive = false
                logoImageVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
                chageView(to: MovetoView.login.rawValue)
            }
        }
    }
    
    public func checkNeededRegistrationAndChageView() {
        if let _ = KeychainWrapper.standard.integer(forKey: .apiFamilyId) {
            chageView(to: MovetoView.home.rawValue )
        } else {
            chageView(to: MovetoView.registrationGuide.rawValue)
        }
    }
    
    public func chageView(to SegueIdentifier : String) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.view.layoutIfNeeded()
                       },
                       completion: { _ in
                        self.performSegue(withIdentifier: SegueIdentifier, sender: nil)
                       })
    }
}
