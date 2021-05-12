//
//  ReplaceRootViewSegue.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/07.
//

import UIKit

enum MovetoView: String {
    case login = "moveToLoginView"
    case membershipRegistration = "moveToMembershipRegistrationView"
    case registrationGuide = "moveToRegistrationGuideView"
    case home = "moveToHome"
    case walkRecode = "moveToWalkRecode"
    
}

class ReplaceRootViewSegue: UIStoryboardSegue {
    override func perform() {
        var window: UIWindow?
        
        if #available(iOS 13.0, *) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            window = sceneDelegate.window
        } else {
            guard let appDelegate = UIApplication.shared.delegate,
                  let appWindow = appDelegate.window else {
                return
            }
            
            window = appWindow
        }
        
        window?.rootViewController?.view.removeFromSuperview()
        window?.rootViewController?.removeFromParent()
        
        window?.rootViewController = destination
        
        if let mainWindow = window {
            UIView.transition(with: mainWindow, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        }
        
    }

}
