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

    let list: [ProfileCell] = [
        ProfileCell.vaild(image: Profile.Item.init(imageName: "Test")),
        ProfileCell.vaild(image: Profile.Item.init(imageName: nil)),
        ProfileCell.empty
    ]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
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
            let wrappedEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyProfileCollectionViewCell", for: indexPath) as? EmptyProfileCollectionViewCell
            
            guard let emptyCell = wrappedEmptyCell else { return UICollectionViewCell() }
            
            return emptyCell
        case .vaild(let profileItem):
            let wrappedVaildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "vaildProfileCollectionViewCell", for: indexPath) as? VaildProfileCollectionViewCell
            
            guard let VaildCell = wrappedVaildCell else { return UICollectionViewCell() }
            
            VaildCell.profileImageView.image = UIImage(named: profileItem.imageName ?? "somsom")
            
            return VaildCell
        }
        
    }
    
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layer = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero}
        
        let height = layer.itemSize.height
        let width = height
        
        return CGSize(width: width, height: height)
    }
}
