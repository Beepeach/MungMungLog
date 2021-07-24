//
//  DetailDateViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/15.
//

import UIKit

class DetailDateViewController: UIViewController {
    // MARK: Properties
    private var date: Date?

    // MARK: @IBOutlet
    @IBOutlet weak var recordCategoryLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordCategoryCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!

    // MARK: @IBAction
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = date?.koreanDateFormatted
        
    }
    
    // MARK: Interface
    public func setDate(date: Date) {
        self.date = date
    }
}


// MARK: - UICollectionViewDataSource
extension DetailDateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recordCategoryCollectionView:
            return HomeViewController().getButtonImagesCount()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case recordCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCategoryCell", for: indexPath) as? RecordCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.iconImageView.image = UIImage(named: HomeViewController().getButtonImageNames()[indexPath.item])
            cell.categoryTitleLabel.text = HomeViewController().getButtonKoreanNames()[indexPath.item]
            
            // TODO: - 글의 갯수를 받아오는 부분 구현예정
                
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


// MARK: - UICollectionView
extension DetailDateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recordCategoryCollectionView {
            return configureCellSize()
        }
        
        return CGSize.zero
    }
    
    private func configureCellSize() -> CGSize {
        let recordCollectionViewWidth = view.frame.width - (recordCategoryLeftConstraint.constant * 2)
        
        let exptectCellWidth: CGFloat = recordCollectionViewWidth * (1 / 3.5)
        let exptectCellHeight: CGFloat = 100
        
        return CGSize(width: exptectCellWidth.rounded(.down), height: exptectCellHeight)
    }
}

