//
//  KeychainWrapper.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/16.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let apiToken: KeychainWrapper.Key = "apiToken"
    static let apiUserId: KeychainWrapper.Key = "apiUserId"
    static let apiFamilyId: KeychainWrapper.Key = "apiFamilyId"
    static let apiEmail: KeychainWrapper.Key = "apiEmail"
    static let apiNickname: KeychainWrapper.Key = "apiNickname"
    static let appleUserEmail: KeychainWrapper.Key = "appleUserEmail"
}

public func deleteKeychainInfo() {
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiEmail.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiToken.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiNickname.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiUserId.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiFamilyId.rawValue)
}
