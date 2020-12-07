//
//  EmptyProfileCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/03.
//

import UIKit

class EmptyProfileCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemGray6
        } else {
            
        }
    }

}
