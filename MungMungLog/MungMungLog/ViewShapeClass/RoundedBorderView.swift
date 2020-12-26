//
//  RoundedBorderView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/27.
//

import UIKit

class RoundedBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        
        layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            
        }
        
        clipsToBounds = true
    }
}
