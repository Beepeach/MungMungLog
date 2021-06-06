//
//  HistoryDateTableViewCell.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/04.
//

import UIKit

class HistoryDateTableViewCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var historyDateField: UITextField!

    // MARK: - CellInit
    override func awakeFromNib() {
        super.awakeFromNib()
        
        historyDateField.delegate = self
    }
    
    private func setHistoryDateFieldAsDefault() {
        historyDateField.tintColor = .clear
        historyDateField.textColor = .lightGray
        historyDateField.text = "날짜를 선택해주세요."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - UITextFieldDelegate
extension HistoryDateTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case historyDateField:
            return false
        default:
            return true
        }
    }
}
