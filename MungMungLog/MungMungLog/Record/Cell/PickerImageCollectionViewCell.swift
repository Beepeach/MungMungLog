//
//  PickerImageCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/14.
//

import UIKit

class PickerImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .systemTeal
        layer.borderWidth = 0.5
    }
}
