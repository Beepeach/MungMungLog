//
//  RecordHistoryDetailViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/04.
//

import UIKit

public enum HistoryType: String {
    case meal = "식사"
    case snack = "간식"
    case pill = "약"
    case hospital = "병원"
    case walk = "산책"
}

class RecordHistoryDetailViewController: UIViewController {
    // MARK: - Enum
    private enum CellOfHistoryDetailView: CaseIterable {
        case image
        case date
        case contents
    }
    
    // MARK: - Properties
    var historyType: HistoryType?
    var photoList: [UIImage] = [UIImage]()
    
    // MARK: - @IBOutlet
    @IBOutlet var historyDateInputView: UIView!
    @IBOutlet var historyDateDoneButtonToolbar: UIToolbar!
    
    // MARK: - @IBAction
    @IBAction func selectHistoryDate(_ sender: Any) {
//        guard let historyDatePicker = historyDateInputView.subviews.first as? UIDatePicker else { return }
//
//        if #available(iOS 12.0, *) {
//            cell.historyDateField.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
//        } else {
//            cell.historyDateField.textColor = .black
//        }
//
//        cell.historyDateField.text = historyDatePicker.date.FullTimeKoreanDateFormatted
//        cell.historyDateField.resignFirstResponder()
//
//        cell.historyDateField.inputView = historyDateInputView
//        cell.historyDateField.inputAccessoryView = historyDateDoneButtonToolbar
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitleAsDefault()
  
    }

    private func setNavTitleAsDefault() {
        self.title = "\(historyType?.rawValue ?? "") 기록"
    }
    
    // MARK: - @IBAction
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveHistory(_ sender: Any) {
        // API호출
        
    }
}


// MARK: - UITableViewDataSource
extension RecordHistoryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellOfHistoryDetailView.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? HistoryImageTableViewCell else {
                 return UITableViewCell()
            }
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as? HistoryDateTableViewCell else {
                 return UITableViewCell()
            }
            
 
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as? HistoryContentsTableViewCell else {
                 return UITableViewCell()
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}



// MARK: - UICollectionViewDataSource
extension RecordHistoryDetailViewController: UICollectionViewDataSource {
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
            
            photoCell.photoImageView.image = photoList[indexPath.row]
            
            return photoCell
            
        default:
            return UICollectionViewCell()
        }
    }
}
