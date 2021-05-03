//
//  MyPageViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/06.
//

import UIKit
import SwiftKeychainWrapper

// 임시 구조체일뿐
struct DummyFamily {
    var isFamilyHead: Bool = false
    var nickname: String
    var relationship: String
    var totalWalkDistance: Double
    var profileImage: String?
}

class MyPageViewController: UIViewController {
    
    var familyList = [
        DummyFamily(isFamilyHead: true, nickname: "아빠", relationship: "돈줄", totalWalkDistance: 100, profileImage: "Test"),
        DummyFamily(nickname: "엄마", relationship: "돈줄2", totalWalkDistance: 110, profileImage: "Test2"),
        DummyFamily(nickname: "셔틀", relationship: "팝콘셔틀", totalWalkDistance: 12, profileImage: "Test3")
    ].sorted { (lhs, rhs) -> Bool in
        return lhs.totalWalkDistance > rhs.totalWalkDistance
    }
    
    var familyMemberList: [FamilyMemberEntity] = CoreDataManager.shared.fetchFamilyMemberData()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var petProfileImageView: UIImageView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petGenderImageView: UIImageView!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userRelationshipLabel: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var optionListContainerView: UIView!
    
    @IBOutlet weak var optionListContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBAction func showOptionList(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { [self] in
            optionListContainerViewLeadingConstraint.constant = optionListContainerViewLeadingConstraint.constant == 0 ? hideList() : showList()
            self.view.layoutIfNeeded()
        }
        
    }
    
    @discardableResult
    func showList() -> CGFloat {
        dimmingView.isHidden = false
        scrollView.isScrollEnabled = false
        return 0
    }
    
    @discardableResult
    func hideList() -> CGFloat {
        dimmingView.isHidden = true
        scrollView.isScrollEnabled = true
        return scrollView.frameLayoutGuide.layoutFrame.width / 2
    }
    
    @IBAction func moveRegistrationGuideView(_ sender: Any) {
        performSegue(withIdentifier: MovetoView.registrationGuide.rawValue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
        
        optionListContainerViewLeadingConstraint.constant = scrollView.frameLayoutGuide.layoutFrame.width / 2

        if let userId = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.apiUserId),
           let user = CoreDataManager.shared.fetchUserData(with: userId).first {
            userNicknameLabel.text = user.nickname
            userRelationshipLabel.text = user.relationship
            
            if let urlStr = user.fileUrl,
               let url = URL(string: urlStr) {
                if let fileName = url.absoluteString.components(separatedBy: "/").last {
                    if let localUrl = FileManager.cacheDirectoryUrl?.appendingPathComponent(fileName) {
                        do {
                            let data = try Data(contentsOf: localUrl)
                            let img = UIImage(data: data)
                            userProfileImageView.image = img
                        } catch {
                            print(error)
                        }
                    }
                }
            }
          
        }
        
        if let _ = KeychainWrapper.standard.integer(forKey: KeychainWrapper.Key.apiFamilyId) {
            
        } else {
            // 기본화면
            petProfileImageView.image = UIImage(named: "MemberDefault")
            
            petNameLabel.isHidden = true
            petBreedLabel.isHidden = true
            petGenderImageView.isHidden = true
            petAgeLabel.isHidden = true
            
            guideLabel.text = "반려견을 등록해주시거나\n구성원으로 참여해주세요."
            guideLabel.isHidden = false
            
            
        }
        
        //        scrollView.bounces = scrollView.contentOffset.y > 0
        // inset을 없앨까..?
        //        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
    }
    
    // 여러개는 안나오네..? 이유가 뭘까
    // dispatchQueue 없애고 willLayout으로 옮기니까 성공!
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
}


extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if familyMemberList.count == 0 {
            return 1
        } else {
            return familyMemberList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if familyMemberList.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? CodeButtonTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FamilyTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
        //        cell.familyProfileImageView.image = UIImage(named: familyList[indexPath.row].profileImage ?? "")
        //        cell.nicknamelabel.text = familyList[indexPath.row].nickname
        //        cell.relationshipLabel.text = familyList[indexPath.row].relationship
        //        cell.totalDistanceLabel.text = "\(familyList[indexPath.row].totalWalkDistance)Km"
        //        cell.familyHeadIconImageView.isHidden = !familyList[indexPath.row].isFamilyHead
        
        
    }
}


extension MyPageViewController: UITableViewDelegate {
    
}
