//
//  RoundedBorderView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/27.
//

import UIKit

class RoundedBorderWithShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
}
