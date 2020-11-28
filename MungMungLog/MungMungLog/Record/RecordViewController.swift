//
//  RecordViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/28.
//

import UIKit

class RecordViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let startButtonContainerView = view.subviews.first else { return }
        startButtonContainerView.layer.cornerRadius = startButtonContainerView.frame.height / 2
    }
    
    

}
