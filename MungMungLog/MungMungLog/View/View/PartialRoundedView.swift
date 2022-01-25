//
//  PartialRoundedView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/02/28.
//

import UIKit

class PartialRoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 30
    }

}
