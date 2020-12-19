//
//  RecordItemTableViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/19.
//

import UIKit

class RecordItemTableViewCell: UITableViewCell {

    @IBOutlet weak var recordItemContentView: UIView!
    @IBOutlet weak var recordItemImageView: UIImageView!
    @IBOutlet weak var recordItemTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recordItemContentView.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            recordItemContentView.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
        recordItemContentView.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
