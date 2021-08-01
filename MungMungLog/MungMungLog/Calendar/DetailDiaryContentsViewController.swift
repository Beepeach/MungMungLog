//
//  DetailDiaryContentsViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/31.
//

import UIKit

class DetailDiaryContentsViewController: UIViewController {
    private let dummyImage: [UIImage?] = [UIImage(named: "Test"),
                                         UIImage(named: "Test2"),
                                         UIImage(named: "Test3")
    ]
    
    private let cellIdentifier: String = "DetailDiaryContentImageCollectionViewCell"
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var contents: UITextView!
    
    @IBAction func changePage(_ sender: Any) {
        let currentPage: Int = pager.currentPage
        let targetIndex: IndexPath = IndexPath(item: currentPage, section: 0)
        
        imageCollectionView.scrollToItem(at: targetIndex, at: .centeredHorizontally, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pager.numberOfPages = dummyImage.count
        pager.currentPage = 0
        pager.hidesForSinglePage = true
    }
}


extension DetailDiaryContentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? DetailDiaryContentImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = dummyImage[indexPath.item]
        
        return cell
    }
}


extension DetailDiaryContentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}


extension DetailDiaryContentsViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetOfX: CGFloat = scrollView.contentOffset.x
        let width:CGFloat = scrollView.frame.width
        
        let page: CGFloat = offsetOfX / width
        
        pager.currentPage = Int(page)
    }
}
