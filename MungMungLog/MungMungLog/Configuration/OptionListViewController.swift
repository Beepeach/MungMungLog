//
//  OptionListViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/27.
//

import UIKit

enum Options: String, CaseIterable {
    case userInfo = "내 정보 수정"
    case petInfo = "반려견 정보 수정"
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
            cell.textLabel?.text = Options.userInfo.rawValue
            return cell
        case 1:
            cell.textLabel?.text = Options.petInfo.rawValue
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

enum ViewError:Error {
    case emptyView
    case Unknown
}


enum NavigationControllers: String {
    case userInfo = "userInfoNav"
    case petInfo = "petInfoNav"
    case familyInfo = "familyInfoNav"
    case qna = "qnaNav"
}

extension OptionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0:
            presentConfigNav(storyboardId: .userInfo)
        case 1:
            // 추후에 target을 이용해서 여러마리의 반려견 화면이 나오도록 하자.
            presentConfigNav(storyboardId: .petInfo)
        case 2:
            presentConfigNav(storyboardId: .familyInfo)
        case 3:
            presentConfigNav(storyboardId: .qna)
        case 4:
            presentTwoButtonAlert(alertTitle: "알림", message: "로그아웃 하시겠습니까??", confirmActionTitle: "로그아웃", cancelActionTitle: "취소") { (_) in
                deleteKeychainInfo()
                CoreDataManager.shared.deleteAllEntities()
                    
                self.performSegue(withIdentifier: MovetoView.login.rawValue, sender: nil)
            }
        default:
            break
        }
    }
    
    private func presentConfigNav(storyboardId: NavigationControllers) {
        do {
            let nav = try createNav(identifier: storyboardId.rawValue)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch {
            presentOneButtonAlert(alertTitle: "알림", message: "화면전환에 실패했습니다.", actionTitle: "확인")
        }
    }
    
    private func createNav(identifier: String) throws -> UINavigationController {
        guard let nav = storyboard?.instantiateViewController(withIdentifier: identifier) as? UINavigationController else {
            throw ViewError.emptyView
        }

        return nav
    }
}
