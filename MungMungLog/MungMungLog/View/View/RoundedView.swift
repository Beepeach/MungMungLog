//
//  RoundedView.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius =  newValue
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        guard let grayBlack = UIColor(named: "MyGrayBalck") else { return }
        
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}

class RoundedWithShadowView: RoundedView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.6
        
    }
}
