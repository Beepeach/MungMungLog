//
//  PickerImageCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/14.
//

import UIKit

class PickerImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCountContainerView: UIView!
    @IBOutlet weak var countLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.5
        
        imageCountContainerView.layer.cornerRadius = imageCountContainerView.bounds.width / 2
        imageCountContainerView.isHidden = true
        countLable.text = nil
    }
}
