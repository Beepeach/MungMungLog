//
//  RoundedView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/30.
//

import UIKit

class CircleWithShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
    
}
