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

class RecordDetailViewController: UIViewController {
    
    // 더미데이터
    var photoList: [PhotoItem] = [
        PhotoItem(photoName: "Test"),
        PhotoItem(photoName: "enroll"),
        PhotoItem(photoName: "Test"),
        PhotoItem(photoName: "Test")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

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
