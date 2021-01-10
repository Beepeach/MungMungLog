//
//  RoundedView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

class RoundedView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}
