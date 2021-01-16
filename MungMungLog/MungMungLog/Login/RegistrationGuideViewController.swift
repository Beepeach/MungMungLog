//
//  RegistrationGuideViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class RegistrationGuideViewController: UIViewController {

    @IBOutlet weak var addPetButtonContainerView: RoundedView!
    @IBOutlet weak var joinButtonConatinerView: RoundedView!
    
    @IBAction func addPet(_ sender: Any) {
    }
    
    @IBAction func join(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 클릭시 파란색으로 변경되는데
        if #available(iOS 13.0, *) {
            addPetButtonContainerView.backgroundColor = .systemGray4
            joinButtonConatinerView.backgroundColor = .systemGray4
        } else {
            addPetButtonContainerView.backgroundColor = .lightGray
            joinButtonConatinerView.backgroundColor = .lightGray
        }
    }
}
