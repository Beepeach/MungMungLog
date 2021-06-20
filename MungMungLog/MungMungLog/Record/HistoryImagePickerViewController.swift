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
    private var allUserImages: PHFetchResult<PHAsset>? = nil
    private var selectedImages: [SelectedPHAsset] = []
    private var selectedImageCount: Int = 0
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: @IBAction
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func selectImages(_ sender: Any) {
        
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        configureToDefaultLayout()
        
        let allPhotoOptions: PHFetchOptions = PHFetchOptions()
        allPhotoOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allUserImages = PHAsset.fetchAssets(with: allPhotoOptions)
    }
    
    private func configureToDefaultLayout() {
        if let flowLayout: UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets.zero
        }
    }
}


// MARK: - UICollectionViewDataSource
extension HistoryImagePickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allUserImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.pickerImageCellIdentifier, for: indexPath) as? PickerImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let asset = allUserImages?.object(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: cell.imageView.bounds.size, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            guard let image = image else { return }
            cell.imageView.image = image
        })
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HistoryImagePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let maxSelectedCount: Int = 5
        
        return selectedImageCount >= maxSelectedCount ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? PickerImageCollectionViewCell else {
            return
        }
        
        if let asset = allUserImages?.object(at: indexPath.item) {
            selectedCell.layer.borderColor = UIColor.systemPink.cgColor
            selectedCell.layer.borderWidth = 1
            self.selectedImageCount += 1
            
            selectedImages.append(SelectedPHAsset(asset: asset, indexPath: indexPath))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? PickerImageCollectionViewCell else {
            return
        }
        
        if let deletedIndex = selectedImages.firstIndex(where: { $0.getIndexPath() == indexPath }) {
            selectedCell.layer.borderColor = UIColor.black.cgColor
            selectedCell.layer.borderWidth = .zero
            
            self.selectedImageCount -= 1
            selectedImages.remove(at: deletedIndex)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HistoryImagePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout: UICollectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        
        let expectedHorizonCellCount: CGFloat = 3
        let expectedVerticalCellCount: CGFloat = 5
        
        let otherHorizonInset: CGFloat = calculateOtherHorizonInset(layout: layout, cellCount: expectedHorizonCellCount)
        let otherVerticalInset: CGFloat = calculateOtherVerticalInset(layout: layout, cellCount: expectedHorizonCellCount)
        
        let collectionViewWidth: CGFloat = collectionView.bounds.width
        let collectionViewHeight: CGFloat = collectionView.bounds.height + collectionView.bounds.origin.y
        
        
        
        let expectedCellWidth: CGFloat = (collectionViewWidth - otherHorizonInset)  / expectedHorizonCellCount
        let exptectedCellHeigth: CGFloat = (collectionViewHeight - otherVerticalInset) / expectedVerticalCellCount
        
        return CGSize(width: expectedCellWidth.rounded(.down), height: exptectedCellHeigth.rounded(.down))
    }
    
    private func calculateOtherHorizonInset(layout: UICollectionViewFlowLayout, cellCount: CGFloat) -> CGFloat {
        let sectionHorizonInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let itemInset: CGFloat = layout.minimumInteritemSpacing * (cellCount - 1)
        let otherHorizonInset: CGFloat = sectionHorizonInset + itemInset
        
        return otherHorizonInset
    }
    
    private func calculateOtherVerticalInset(layout: UICollectionViewFlowLayout, cellCount: CGFloat) -> CGFloat {
        let sectionVerticalInset: CGFloat = layout.sectionInset.top + layout.sectionInset.bottom
        let lineInset: CGFloat = layout.minimumLineSpacing * (cellCount - 1)
        let otherVerticalInset: CGFloat = sectionVerticalInset + lineInset
        
        return otherVerticalInset
    }
}
