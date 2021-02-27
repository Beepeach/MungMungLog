//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

struct Profile {
    struct Item {
        let imageName: String?
    }
}

enum ProfileCell {
    case empty
    case vaild(image: Profile.Item)
}

class HomeViewController: UIViewController {
    
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        guard let layer = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero}
//
//        let height = layer.itemSize.height
//        let width = height
//
//        let target = list[indexPath.item]
//
//        switch target {
//        case .invisible:
//            return CGSize(width: (collectionView.bounds.width / 2) + 100, height: width)
//        default:
//            return CGSize(width: width, height: height)
//        }
//    }
}
