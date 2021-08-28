//
//  LauchScreenViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/07.
//

import UIKit
import SwiftKeychainWrapper

class IntroViewController: UIViewController {
    // MARK: Properies
    private var topAnchorOfLogo: NSLayoutYAxisAnchor {
        return logoImageVIew.topAnchor
    }
    
    // MARK: @IBOutlet
    @IBOutlet weak var logoImageVIew: UIImageView!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        placeLogoAtCenterY(isActive: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let _ = KeychainWrapper.standard.string(forKey: .apiToken),
               let _ = KeychainWrapper.standard.string(forKey: .apiUserId) {
                checkNicknameKeychain()
            } else {
                placeLogoAtCenterY(isActive: false)
                placeLogoAtTopPosition(isActive: true)
                chageView(to: MovetoView.login.rawValue)
            }
        }
    }
    
    private func checkNicknameKeychain() {
        if let nickname = KeychainWrapper.standard.string(forKey: .apiNickname),
           nickname.count > 0 {
            checkFamilyKeychain()
        } else {
            chageView(to: MovetoView.membershipRegistration.rawValue)
        }
    }
    
    private func checkFamilyKeychain() {
        if let _ = KeychainWrapper.standard.integer(forKey: .apiFamilyId) {
            chageView(to: MovetoView.home.rawValue )
        } else {
            chageView(to: MovetoView.registrationGuide.rawValue)
        }
    }
    
    private func chageView(to segueIdentifier : String) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.view.layoutIfNeeded()
                       },
                       completion: { _ in
                        self.performSegue(withIdentifier: segueIdentifier, sender: nil)
                       })
    }
    
    private func placeLogoAtCenterY(isActive: Bool) {
        topAnchorOfLogo.constraint(equalTo: view.centerYAnchor, constant: -(logoImageVIew.frame.height / 2)).isActive = true
    }
    
    private func placeLogoAtTopPosition(isActive: Bool) {
        topAnchorOfLogo.constraint(equalTo: view.topAnchor, constant: 60).isActive = isActive
    }
}
