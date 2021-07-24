//
//  ContentCollectionViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/24.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var WriterImageView: UIImageView!
    @IBOutlet weak var contentSummaryTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        WriterImageView.layer.cornerRadius = WriterImageView.frame.height / 2
    }
}

extension ContentCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentSummaryTableViewCell", for: indexPath)
        
        return cell
    }
}
