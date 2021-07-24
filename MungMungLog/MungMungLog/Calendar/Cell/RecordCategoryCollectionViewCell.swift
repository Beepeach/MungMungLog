//
//  RecordCategoryCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/19.
//

import UIKit

class RecordCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var contentsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
