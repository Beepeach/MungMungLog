//
//  UIViewController+KeychainWrapper.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/09.
//

import Foundation
import SwiftKeychainWrapper

extension UIViewController {
    // 제네릭을 이용하요 Login, JoinResponse 둘다 사용가능 하도록 바꿀수 없을까??
    
    func saveUserDataInKeychainAndCoreData(with responseData: LoginAndJoinResponseModel) {
        if let token = responseData.token {
            KeychainWrapper.standard.set(token, forKey: KeychainWrapper.Key.apiToken.rawValue)
        }
        
        if let userId = responseData.user?.id {
            KeychainWrapper.standard.set(userId, forKey: KeychainWrapper.Key.apiUserId.rawValue)
        }
        
        
        if let email = responseData.email {
            KeychainWrapper.standard.set(email, forKey: KeychainWrapper.Key.apiEmail.rawValue)
        }
        
        if let nickname = responseData.user?.nickname {
            KeychainWrapper.standard.set(nickname, forKey: KeychainWrapper.Key.apiNickname.rawValue)
        }
        
        if let familyId = responseData.familyMember?.familyId {
            KeychainWrapper.standard.set(familyId, forKey: KeychainWrapper.Key.apiFamilyId.rawValue)
        }
        
        // 서버에 성공했으면 userDto를 coredata에 저장
        if let user = responseData.user {
            let target = CoreDataManager.shared.fetchUserData(with: user.id).first
            CoreDataManager.shared.upsertUser(target: target, dto: user)
        }
    }
}
