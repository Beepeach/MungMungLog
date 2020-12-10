//
//  RecordItemSelectViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/10.
//

import UIKit

class RecordItemSelectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let iconContainerViews = view.subviews.first?.subviews {
            for iconContainerView in iconContainerViews {
                iconContainerView.layer.borderColor = UIColor.systemTeal.cgColor
                iconContainerView.layer.borderWidth = 5
                iconContainerView.layer.cornerRadius = 10
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
