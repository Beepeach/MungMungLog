//
//  FamilyTableViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/07.
//

import UIKit

class FamilyTableViewCell: UITableViewCell {

    @IBOutlet weak var familyProfileImageView: UIImageView!
    @IBOutlet weak var nicknamelabel: UILabel!
    @IBOutlet weak var relationshipLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var familyHeadIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        familyHeadIconImageView.isHidden = true
        
        familyProfileImageView.layer.cornerRadius = familyProfileImageView.frame.height / 2
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
