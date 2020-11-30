//
//  RoundedView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/30.
//

import UIKit

class RoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
}
