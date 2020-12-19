//
//  RecodEditingViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/09.
//

import UIKit

enum EditingCell {
    case photo(image: UIImage?)
    case date
    case walkData(time: Date?, distance: Double?)
    case content(text: String)
}

class WalkRecordEditingViewController: UIViewController {
    
    var dummyData: [EditingCell] = [
        .photo(image: nil),
        .date,
        .walkData(time: Date(), distance: 1.3),
        .content(text: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


extension WalkRecordEditingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let target = dummyData[indexPath.row]
        
        switch target {
        case .photo(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoSelectCell", for: indexPath) as? PhotoSelectCollectionViewCell else {
                return UICollectionViewCell()
                
            }
            
            return cell
            
        case .date:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateSelectCell", for: indexPath) as? DateSelectCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.walkDatePicker.minimumDate = Date()
            
            return cell
            
        case .walkData(_, _):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walkTimeAndDistanceDataCell", for: indexPath) as? WalkTimeAndDistanceDataCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        case .content(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentRecodeCell", for: indexPath) as? ContentRecodeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        }
    }
}


