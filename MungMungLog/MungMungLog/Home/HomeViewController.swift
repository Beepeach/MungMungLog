//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit
import SwiftKeychainWrapper

class HomeViewController: UIViewController {
    var menuStack: UIStackView?
    let buttonImageNames = ["rice", "snack", "pill", "hospital", "walk"]
    
    var petList: [PetDto]?
    var historyList: [HistoryDto]?
    var walkHistoryList: [WalkHistoryDto]?
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petProfileImageView: UIImageView!
    
    
    @IBOutlet weak var historyContentsContainerView: UIView!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    @IBOutlet weak var writerProfileImageView: UIImageView!
    @IBOutlet weak var writerNicknameLabel: UILabel!
    @IBOutlet weak var latestHistroyLabel: UILabel!
    @IBOutlet weak var latestHistoryDateLabel: UILabel!
    
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
        
        
        stack.bottomAnchor.constraint(equalTo: floatingButtonContainerView.topAnchor, constant: -10).isActive = true
        
        return stack
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        writerProfileImageView.layer.cornerRadius = writerProfileImageView.frame.height / 2
        
        menuStack = createMenuStackView()
        
        fetchData()
    }
    
    func fetchData() {
        
        guard let url = URL(string: ApiManager.getPetList) else {
            print(#function, ApiError.invalidURL)
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(#function, error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print(#function, ApiError.failed((response as? HTTPURLResponse)?.statusCode ?? -999))
                return
            }
            
            guard let data = data else {
                print(#function, ApiError.emptyData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(ListResponse<PetDto>.self, from: data)
                
                self.petList = responseData.list
                self.historyList = responseData.list.first?.histories
                self.walkHistoryList = responseData.list.first?.walkHistories
                
                self.showHomeWithFirstPetData()
                self.showHomeWithFirstHistoryData()
                
            } catch {
                print(#function, error)
            }
        }
        
        task.resume()
    }
    
    func showHomeWithFirstPetData() {
        guard let firstPet = petList?.first else {
             return
        }
        
        DispatchQueue.main.async { [self] in
            petNameLabel.text = firstPet.name
            petBreedLabel.text = firstPet.breed
        }
    }
    
    func showHomeWithFirstHistoryData() {
        DispatchQueue.main.async { [self] in
            latestHistoryDateLabel.text = koreaDateFormatter.string(for: Date())
        }
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
        
        switch indexPath.row {
        case 0:
            showLatestHistory(to: cell, with: 0)
            
        case 1:
            showLatestHistory(to: cell, with: 1)
            
        case 2:
            showLatestHistory(to: cell, with: 2)
            
        case 3:
            showLatestHistory(to: cell, with: 3)
            
        case 4:
            showLatestHistory(to: cell, with: 4)
            
        default:
            break
        }

    }
    
    func showLatestHistory(to cell: RecordContentsCollectionViewCell, with type: Int) {
        moveUp(to: cell)
        
        if let latestHistory = historyList?.filter({ $0.type == type }).first {
            self.writerNicknameLabel.text = "\(latestHistory.familyMemberId)"
            self.latestHistroyLabel.text = latestHistory.contents
            self.latestHistoryDateLabel.text = koreaDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: latestHistory.date))
        } else {
            showHomeWithFirstHistoryData()
        }
        
    }
    
    func moveUp(to cell: RecordContentsCollectionViewCell) {
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
            cell.contentsIconContainerView.backgroundColor = UIColor(named: "MyDefaultColor")
        }
    }
}
