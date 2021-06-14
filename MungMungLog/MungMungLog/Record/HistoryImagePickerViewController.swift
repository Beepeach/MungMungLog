//
//  HistoryImagePickerViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/14.
//

import UIKit
import Photos

class HistoryImagePickerViewController: UIViewController {
    private let pickerImageCellIdentifier: String = "cell"
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        guard let flowLayout: UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.zero
    }
}


// MARK: - UICollectionViewDataSource
extension HistoryImagePickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.pickerImageCellIdentifier, for: indexPath) as? PickerImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HistoryImagePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HistoryImagePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        
        let collectionViewWidth: CGFloat = collectionView.bounds.width
        let collectionViewHeight: CGFloat = collectionView.bounds.height + collectionView.bounds.origin.y
        
        let sectionHorizonInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let sectionVerticalInset: CGFloat = layout.sectionInset.top + layout.sectionInset.bottom
        
        let itemInset: CGFloat = layout.minimumInteritemSpacing
        let lineInset: CGFloat = layout.minimumLineSpacing
        let otherInset:CGFloat = sectionHorizonInset + itemInset + lineInset
        
        let expectedCellWidth: CGFloat = (collectionViewWidth - otherInset)  / 3
        let exptectedCellHeigth: CGFloat = (collectionViewHeight - sectionVerticalInset) / 5
        
        
        return CGSize(width: expectedCellWidth.rounded(.down), height: exptectedCellHeigth.rounded(.down))
    }
}
