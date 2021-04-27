//
//  OptionListViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/27.
//

import UIKit

enum Options: String, CaseIterable {
    case userProfile = "내 정보 수정"
    case petProfile = "반려견 정보 수정"
    case familyInfo = "구성원 설정"
    case qna = "문의하기"
    case logout = "로그아웃"
}

class OptionListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension OptionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Options.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = Options.userProfile.rawValue
            return cell
        case 1:
            cell.textLabel?.text = Options.petProfile.rawValue
            return cell
        case 2:
            cell.textLabel?.text = Options.familyInfo.rawValue
            return cell
        case 3:
            cell.textLabel?.text = Options.qna.rawValue
            return cell
        case 4:
            cell.textLabel?.text = Options.logout.rawValue
            return cell
        default:
            return cell
                
        }
    }
}


extension OptionListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
}
