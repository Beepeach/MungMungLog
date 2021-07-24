//
//  ContentSummaryTableViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/24.
//

import UIKit

class ContentSummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var writeTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
