//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

struct Profile {
    struct Item {
        let imageName: String
    }
}

enum ProfileCell {
    case empty
    case vaild(image: Profile.Item)
}

class HomeViewController: UIViewController {
    
    let list: [ProfileCell] = [
        ProfileCell.vaild(image: Profile.Item.init(imageName: "Test")),
        ProfileCell.empty
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let targetCell = list[indexPath.row]
        switch targetCell {
        case .empty:
            let wrappedEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyProfileCell", for: indexPath) as? EmptyProfileCollectionViewCell
            
            guard let emptyCell = wrappedEmptyCell else { return UICollectionViewCell() }
            
            return emptyCell
        case .vaild(let profileItem):
            let wrappedVaildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? VaildProfileCollectionViewCell
            
            guard let VaildCell = wrappedVaildCell else { return UICollectionViewCell() }
            
            VaildCell.profileImageView.image = UIImage(named: profileItem.imageName)
            
            return VaildCell
        }
        
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate {
    
}
