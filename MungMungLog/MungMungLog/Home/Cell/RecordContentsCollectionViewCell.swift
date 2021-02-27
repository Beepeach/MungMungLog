//
//  RecordContentsCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/02/27.
//

import UIKit

class RecordContentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        layer.cornerRadius = self.frame.width / 2
        contentsImageView.layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        
        contentsImageView.image = UIImage(named: "rice")
        contentsTitleLabel.text = "Food"
    }
}
