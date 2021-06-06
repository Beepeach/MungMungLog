//
//  RecordItemSelectViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/10.
//

import UIKit


struct PhotoItem {
    let photoName: String
}

//enum HistoryType: String {
//    case meal = "식사"
//    case snack = "간식"
//    case pill = "약"
//    case hospital = "병원"
//    case walk = "산책"
//}

class RecordDetailViewController: UIViewController {
    
    // MARK: - DummyData
    var photoList: [PhotoItem] = [
        PhotoItem(photoName: "Test"),
        PhotoItem(photoName: "enroll"),
        PhotoItem(photoName: "Test"),
        PhotoItem(photoName: "Test")
    ]
    
    // MARK: - Properties
    var historyType: HistoryType?
    
    // MARK: - @IBOutlet
    @IBOutlet weak var historyDateField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet var historyDateInputView: UIView!
    @IBOutlet var historyDateDoneButtonToolbar: UIToolbar!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitleAndContentsTitleAsDefault()
        setHistoryDateFieldAsDefault()
    }
    
    private func setNavTitleAndContentsTitleAsDefault() {
        contentsTextView.textColor = .lightGray
        self.title = "\(historyType?.rawValue ?? "") 기록"
        titleLabel.text = "오늘의 \(historyType?.rawValue ?? "") 기록"
    }
    
    private func setHistoryDateFieldAsDefault() {
        historyDateField.inputView = historyDateInputView
        historyDateField.inputAccessoryView = historyDateDoneButtonToolbar
        historyDateField.tintColor = .clear
        historyDateField.textColor = .lightGray
        historyDateField.text = "날짜를 선택해주세요."
    }
    
    // MARK: - @IBAction
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveHistory(_ sender: Any) {
        // API호출
        
    }
    
    @IBAction func selectHistoryDate(_ sender: Any) {
        guard let historyDatePicker = historyDateInputView.subviews.first as? UIDatePicker else { return }
        
        if #available(iOS 12.0, *) {
            historyDateField.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        } else {
            historyDateField.textColor = .black
        }
    
        historyDateField.text = historyDatePicker.date.FullTimeKoreanDateFormatted
        historyDateField.resignFirstResponder()
    }
    
}


// MARK: - UICollectionViewDataSource
extension RecordDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : photoList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let addPhotoButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoButtonCell", for: indexPath)
            
            return addPhotoButtonCell
            
        case 1:
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            
            photoCell.photoImageView.image = UIImage(named: photoList[indexPath.row].photoName)
            
            return photoCell
            
        default:
            return UICollectionViewCell()
        }
    }
}


//extension RecordDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let safeAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
//
//        return safeAreaHeight / 5
//
//    }
//}


// MARK: - UITextViewDelegate
extension RecordDetailViewController: UITextViewDelegate {
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
            textView.textColor = .lightGray
            textView.text = "오늘의 기록을 남겨보세요."
        }
    }
}


// MARK: - UITextFieldDelegate
extension RecordDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case historyDateField:
            return false
        default:
            return true
        }
    }
}
