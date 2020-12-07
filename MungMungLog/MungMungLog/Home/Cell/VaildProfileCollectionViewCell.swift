//
//  VaildProfileCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/03.
//

import UIKit

class VaildProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: CircleImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        clipsToBounds = true
    }
}
