//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var contentsCollectionView: UICollectionView!

    @IBOutlet weak var writerProfileImageView: UIImageView!
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writerProfileImageView.layer.cornerRadius = writerProfileImageView.frame.height / 2
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecordContentsCollectionViewCell
        
        // 더 줄일수 있을거 같은데..?
        switch indexPath.row {
        case 0:
            cell.contentsImageView.image = UIImage(named: "rice")
            cell.contentsTitleLabel.text = "식사"
            return cell
        case 1:
            cell.contentsImageView.image = UIImage(named: "snack")
            cell.contentsTitleLabel.text = "간식"
            return cell
        case 2:
            cell.contentsImageView.image = UIImage(named: "pill")
            cell.contentsTitleLabel.text = "약"
            return cell
        case 3:
            cell.contentsImageView.image = UIImage(named: "hospital")
            cell.contentsTitleLabel.text = "병원"
            return cell
        case 4:
            cell.contentsImageView.image = UIImage(named: "walk")
            cell.contentsTitleLabel.text = "산책"
            return cell
        default:
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordContentsCollectionViewCell else { return }
        
        UIView.animate(withDuration: 0.2) {
            cell.contentsTitleLabel.isHidden = false
            
            cell.contentsIconContainerView.backgroundColor = .systemTeal
        } completion: { (_) in
            UIView.animate(withDuration: 0.2) {
                cell.contentsTitleLabel.alpha = 1.0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordContentsCollectionViewCell else { return }
        
        UIView.animate(withDuration: 0.2) {
            cell.contentsTitleLabel.isHidden = true
            cell.contentsTitleLabel.alpha = 0.0
            cell.contentsIconContainerView.backgroundColor = .none
        }
    }
}
