//
//  RecordContentsCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/02/27.
//

import UIKit

class RecordContentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentsIconContainerView: UIView!
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsTitleLabel.isHidden = true
        contentsTitleLabel.alpha = 0.0
        
        contentsIconContainerView.layer.borderWidth = 2
        contentsIconContainerView.layer.borderColor = UIColor.lightGray.cgColor
        contentsIconContainerView.layer.cornerRadius = 25
    }
}
