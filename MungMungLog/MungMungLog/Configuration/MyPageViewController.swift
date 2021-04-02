//
//  MyPageViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/03/06.
//

import UIKit

struct Family {
    var isFamilyHead: Bool = false
    var nickName: String
    var relationship: String
    var totalWalkDistance: Double
    var profileImage: String?
}

class MyPageViewController: UIViewController {
    
    var familyList = [
        Family(isFamilyHead: true, nickName: "아빠", relationship: "돈줄", totalWalkDistance: 100, profileImage: "Test"),
        Family(nickName: "엄마", relationship: "돈줄2", totalWalkDistance: 110, profileImage: "Test2"),
        Family(nickName: "셔틀", relationship: "팝콘셔틀", totalWalkDistance: 12, profileImage: "Test3")
    ].sorted { (lhs, rhs) -> Bool in
        return lhs.totalWalkDistance > rhs.totalWalkDistance
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var petProfileImageView: UIImageView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.bounces = scrollView.contentOffset.y > 0
        
        

        
        // inset을 없앨까..?
//        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        
        
        petProfileImageView.layer.cornerRadius = petProfileImageView.frame.height / 2

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
        return familyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FamilyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.familyProfileImageView.image = UIImage(named: familyList[indexPath.row].profileImage ?? "")
        cell.nickNamelabel.text = familyList[indexPath.row].nickName
        cell.relationshipLabel.text = familyList[indexPath.row].relationship
        cell.totalDistanceLabel.text = "\(familyList[indexPath.row].totalWalkDistance)Km"
        cell.familyHeadIconImageView.isHidden = !familyList[indexPath.row].isFamilyHead
        
        return cell
    }
}


extension MyPageViewController: UITableViewDelegate {
    
}