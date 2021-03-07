//
//  LauchScreenViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/07.
//

import UIKit

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
            logoCenterYAnchor.isActive = false
            logoImageVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true

            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseIn,
                           animations: {
                            self.view.layoutIfNeeded()
                           },
                           completion: { _ in
                            performSegue(withIdentifier: "moveToLoginView", sender: nil)
                           })
        }
        
        
    }
}
