//
//  HomeViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/02.
//

import UIKit
import SwiftKeychainWrapper

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var menuStack: UIStackView?
    
    let buttonImageNames = ["rice", "snack", "pill", "hospital", "walk"]
    var selectedItemIndex = -1
    
    var petList: [PetDto]?
    var historyList: [HistoryDto]?
    var walkHistoryList: [WalkHistoryDto]?
    
    // MARK: - @IBOutlet
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petProfileImageView: UIImageView!
    
    @IBOutlet weak var historyContentsContainerView: UIView!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    @IBOutlet weak var writerProfileImageView: UIImageView!
    @IBOutlet weak var writerNicknameLabel: UILabel!
    @IBOutlet weak var latestHistroyLabel: UILabel!
    @IBOutlet weak var latestHistoryDateLabel: UILabel!
    
    @IBOutlet weak var historyMenuFloatingButtonStackView: UIStackView!
    @IBOutlet weak var dimmingView: UIView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        writerProfileImageView.layer.cornerRadius = writerProfileImageView.frame.height / 2
        historyMenuFloatingButtonStackView.arrangedSubviews.forEach { button in
            button.isHidden = true
            button.alpha = 0.0
        }
        dimmingView.isHidden = true
        
        if let userId = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.apiUserId),
           let user = CoreDataManager.shared.fetchUserData(with: userId).first {
            if let urlStr = user.fileUrl,
               let url = URL(string: urlStr),
               let fileName = url.absoluteString.components(separatedBy: "/").last,
               let localUrl = FileManager.cacheDirectoryUrl?.appendingPathComponent(fileName){
                KeychainWrapper.standard.set("\(localUrl)", forKey: KeychainWrapper.Key.userImageDirectoryURL.rawValue)
            }
            
        }
        
        if let familyId = KeychainWrapper.standard.integer(forKey: KeychainWrapper.Key.apiFamilyId) {
            fetchFamilyMembersData(familyId: familyId)
            
            fetchPetData()
        } else {
            if let urlStr = KeychainWrapper.standard.string(forKey: .userImageDirectoryURL),
               let url = URL(string: urlStr) {
                do {
                    let data = try Data(contentsOf: url)
                    writerProfileImageView.image = UIImage(data: data)
                    writerNicknameLabel.text = KeychainWrapper.standard.string(forKey: .apiNickname)
                } catch {
                    print(error)
                }
            } else {
                writerNicknameLabel.text = KeychainWrapper.standard.string(forKey: .apiNickname)
            }
        }
    }
    
    func fetchFamilyMembersData(familyId: Int) {
        let urlStr = ApiManager.getFamilyMembers + "/\(familyId)"
        
        ApiManager.shared.fetch(urlStr: urlStr) { (result: Result<ListResponse<FamilyMemberDto>, Error>) in
            switch result {
            case .success(let responseData):
                switch responseData.code {
                case Statuscode.ok.rawValue:
                    responseData.list.forEach { familyMember in
                        CoreDataManager.shared.createNewFamilyMember(dto: familyMember)
                    }
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPetData() {
        ApiManager.shared.fetch(urlStr: ApiManager.getPetList) { (result: Result<ListResponse<PetDto>, Error>) in
            switch result {
            case .success(let responseData):
                self.petList = responseData.list
                self.historyList = responseData.list.first?.histories
                self.walkHistoryList = responseData.list.first?.walkHistories
                
                self.showHomeWithFirstPetData()
                self.showHistoryDataWhenFirst()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showHomeWithFirstPetData() {
        guard let firstPet = petList?.first else {
            return
        }
        
        petNameLabel.text = firstPet.name
        petBreedLabel.text = firstPet.breed
        
        guard let urlStr = firstPet.fileUrl,
              let url = URL(string: urlStr),
              let fileName = url.absoluteString.components(separatedBy: "/").last,
              let localURL = FileManager.cacheDirectoryUrl?.appendingPathComponent(fileName) else  {
            return
        }
        KeychainWrapper.standard.set(localURL.absoluteString, forKey: KeychainWrapper.Key.petImageDirectoryURL.rawValue)
        
        do {
            let data = try Data(contentsOf: localURL)
            petProfileImageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
    
    func showHistoryDataWhenFirst() {
        // writerNicknameLabel.text = coredata에서 사용자 사진 가져오기
        // writerProfileImageView.image = coredata에서 사용자 사진 가져오기
        latestHistoryDateLabel.text = koreaFullDateFormatter.string(for: Date())
        latestHistroyLabel.text = "아이콘을 선택해서 가장 최근에 기록한 정보를 확인하세요."
    }
    
    func showHistoryDataIfDataIsNil() {
        // writerNicknameLabel.text = coredata에서 사용자 사진 가져오기
        // writerProfileImageView.image = coredata에서 사용자 사진 가져오기
        latestHistoryDateLabel.text = koreaFullDateFormatter.string(for: Date())
        latestHistroyLabel.text = "저장된 기록이 없어요😭\n기록을 남겨보시겠어요?"
    }
    
    // MARK: - @IBAction
    @IBAction func toggleFloatingButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                         historyMenuFloatingButtonStackView.arrangedSubviews.forEach({ (button) in
                             button.isHidden = button.isHidden ? false : true
                             button.alpha = button.isHidden ? 0.0 : 1.0
                         })
                        
                        dimmingView.isHidden = dimmingView.isHidden ? false : true
                        
                        menuStack?.layoutIfNeeded()
                       },
                       completion: nil)
    }
    
    
    @IBAction func moveToMealVC(_ sender: Any) {
        self.present(createHistoryNav(type: .meal), animated: true, completion: nil)
    }
    
    @IBAction func moveToSnackVC(_ sender: Any) {
        self.present(createHistoryNav(type: .snack), animated: true, completion: nil)
    }
    
    @IBAction func moveToPillVC(_ sender: Any) {
        self.present(createHistoryNav(type: .pill), animated: true, completion: nil)
    }
    
    @IBAction func moveToHospitalVC(_ sender: Any) {
        self.present(createHistoryNav(type: .hospital), animated: true, completion: nil)
    }
    
    @IBAction func moveToWalkVC(_ sender: Any) {
        
    }
    
    func createHistoryNav(type: HistoryType) -> UINavigationController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let recordDetailNav = storyboard.instantiateViewController(withIdentifier: "RecordDetailNav") as? UINavigationController else {
            return UINavigationController()
        }
        
        guard let recordDetailVC = recordDetailNav.topViewController as? RecordDetailViewController else {
            return UINavigationController()
        }
        
        toggleFloatingButton(self)
        
        recordDetailNav.modalPresentationStyle = .fullScreen
        recordDetailVC.setHistoryType(to: type)
        
        return recordDetailNav
    }
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecordContentsCollectionViewCell
        
        if selectedItemIndex == indexPath.item {
            moveUp(to: cell)
        } else {
            moveDown(to: cell)
        }
        
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

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        selectedItemIndex = indexPath.item
        
        for index in 0 ..< buttonImageNames.count {
            let myIndexPath: IndexPath = IndexPath(item: index, section: 0)
            
            guard let cell = collectionView.cellForItem(at: myIndexPath) as? RecordContentsCollectionViewCell else { continue }
            
            if index == selectedItemIndex {
                DispatchQueue.main.async {
                    self.moveUp(to: cell)
                }
                
                if let latestHistory = historyList?.filter({ $0.type == selectedItemIndex }).first {
                    
                    self.showLatestHistory(latestHistory: latestHistory)
                    
                    
                    //                    ApiManager.shared.fetch(urlStr: ApiManager.getUser + "/\(latestHistory.familyMemberId)") { (result: Result<SingleResponse<User>, Error>) in
                    //                        switch result {
                    //                        case .success(let responseData):
                    //                            self.showLatestHistory(responsedata: responseData, latestHistory: latestHistory)
                    //
                    //                        case .failure(let error):
                    //                            self.showHistoryDataIfDataIsNil()
                    //                            print(#function, error)
                    //                        }
                    //                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.moveDown(to: cell)
                }
            }
        }
    }
    
    func showLatestHistory(latestHistory: HistoryDto) {
        if let writerUserId = CoreDataManager.shared.fetchFamilyMemeberData(with: latestHistory.familyMemberId).first?.userId {
            if let writer = CoreDataManager.shared.fetchUserData(with: writerUserId).first {
                self.writerNicknameLabel.text = writer.nickname
            }
        }
        
        self.latestHistroyLabel.text = latestHistory.contents
        self.latestHistoryDateLabel.text = koreaFullDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: latestHistory.date))
    }
    
    func showLatestHistory(responsedata: SingleResponse<User>, latestHistory: HistoryDto) {
        self.writerNicknameLabel.text = responsedata.data?.nickname
        self.latestHistroyLabel.text = latestHistory.contents
        self.latestHistoryDateLabel.text = koreaFullDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: latestHistory.date))
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
    
    func moveDown(to cell: RecordContentsCollectionViewCell) {
        cell.contentsTitleLabel.isHidden = true
        cell.contentsIconContainerView.backgroundColor = UIColor(named: "MyDefaultColor")
        cell.contentsTitleLabel.alpha = 0.0
    }
}
