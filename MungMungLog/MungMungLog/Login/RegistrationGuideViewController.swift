//
//  RegistrationGuideViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class RegistrationGuideViewController: UIViewController {

    @IBOutlet weak var addPetButtonContainerView: RoundedView!
    
    @IBAction func addPet(_ sender: Any) {
        addPetButtonContainerView.backgroundColor = .systemTeal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 13.0, *) {
            addPetButtonContainerView.backgroundColor = .systemGray4
        } else {
            addPetButtonContainerView.backgroundColor = .lightGray
        }
    }
}
