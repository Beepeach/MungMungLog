//
//  HistoryContentsTableViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/04.
//

import UIKit

class HistoryContentsTableViewCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var contentsTextView: UITextView!
    
    
    // MARK: - CellInit
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsTextView.delegate = self
        setContentsTextAsDefault()
    }
    
    private func setContentsTextAsDefault() {
        contentsTextView.textColor = .lightGray
        contentsTextView.text = "오늘의 기록을 남겨보세요."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// MARK: - UITextViewDelegate
extension HistoryContentsTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            
            if #available(iOS 12.0, *) {
                textView.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
            } else {
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setContentsTextAsDefault()
        }
    }
}
