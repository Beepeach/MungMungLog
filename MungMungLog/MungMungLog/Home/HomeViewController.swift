//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit

class HomeViewController: UIViewController {
    var menuStack: UIStackView?
    let buttonImageNames = ["rice", "snack", "pill", "hospital", "walk"]
    
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    @IBOutlet weak var writerProfileImageView: UIImageView!
    
    @IBOutlet weak var floatingButtonContainerView: UIView!
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func showFloatingButton(_ sender: Any) {        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: { [self] in
                        menuStack?.arrangedSubviews.forEach({ (button) in
                            button.isHidden = button.isHidden ? false : true
                        })
                        
                        menuStack?.layoutIfNeeded()
                       }, completion: nil)
    }
    
    func createMenuStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        buttonImageNames.forEach { (imageName) in
            let button = UIButton(type: .system)
            let image = UIImage(named: imageName)
            button.setImage(image, for: .normal)
            stack.addArrangedSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
            button.isHidden = true
        }
        
        floatingButtonContainerView.addSubview(stack)
        
        stack.trailingAnchor.constraint(equalTo: floatingButtonContainerView.trailingAnchor).isActive = true
        
        let floatingButtonTopConstaint = stack.topAnchor.constraint(equalTo: floatingButtonContainerView.topAnchor)
        floatingButtonTopConstaint.priority = .defaultHigh
        floatingButtonTopConstaint.isActive = true
//        stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
//        stack.heightAnchor.constraint(equalToConstant: 290).isActive = true
        
        stack.bottomAnchor.constraint(equalTo: floatingButtonContainerView.topAnchor, constant: -10).isActive = true
        
        return stack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writerProfileImageView.layer.cornerRadius = writerProfileImageView.frame.height / 2
        
        menuStack = createMenuStackView()
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
