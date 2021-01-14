//
//  EditingProfileViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class EditingProfileViewController: UIViewController {
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        maleContainerView.backgroundColor = .none
        femaleContainerView.backgroundColor = .none
    }
    
}
