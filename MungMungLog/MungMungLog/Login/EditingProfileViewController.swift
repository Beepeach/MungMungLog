//
//  EditingProfileViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/14.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    var isMale: Bool = true
    
    @IBOutlet weak var maleContainerView: RoundedView!
    @IBOutlet weak var femaleContainerView: RoundedView!
    
    
    @IBAction func selectMale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            maleContainerView.backgroundColor = .systemGray4
        } else {
            maleContainerView.backgroundColor = UIColor.lightGray
        }
        femaleContainerView.backgroundColor = .none
        isMale = true
    }
    
    @IBAction func selectFemale(_ sender: Any) {
        if #available(iOS 13.0, *) {
            femaleContainerView.backgroundColor = .systemGray4
        } else {
            femaleContainerView.backgroundColor = UIColor.lightGray
        }
        maleContainerView.backgroundColor = .none
        isMale = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        maleContainerView.backgroundColor = .none
        femaleContainerView.backgroundColor = .none
    }
    
}
