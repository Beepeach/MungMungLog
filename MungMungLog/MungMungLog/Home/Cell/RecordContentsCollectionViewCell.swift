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
        
        contentsIconContainerView.layer.borderWidth = 1
        contentsIconContainerView.layer.borderColor = UIColor.darkGray.cgColor
        contentsIconContainerView.layer.cornerRadius = 25
        
//        contentsImageView.image = UIImage(named: "rice")
//        contentsTitleLabel.text = "Food"
    }
}
