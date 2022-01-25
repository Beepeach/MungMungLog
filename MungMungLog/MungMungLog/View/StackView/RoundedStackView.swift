//
//  RoundedStackView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/01/12.
//

import UIKit

class RoundedStackView: UIStackView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius =  newValue
        }
        
    }
    
}
