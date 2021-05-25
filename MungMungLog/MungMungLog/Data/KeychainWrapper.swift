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
    static let apiPetId: KeychainWrapper.Key = "apiPetId"
    static let apiFamilyMemberId: KeychainWrapper.Key = "apiFamilyMemberId"
    static let apiEmail: KeychainWrapper.Key = "apiEmail"
    static let apiNickname: KeychainWrapper.Key = "apiNickname"
    static let appleUserEmail: KeychainWrapper.Key = "appleUserEmail"
    static let userImageDirectoryURL: KeychainWrapper.Key = "userImageDirectoryURL"
    static let petImageDirectoryURL: KeychainWrapper.Key = "petImageDirectoryURL"
}

public func deleteKeychainInfo() {
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiEmail.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiToken.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiNickname.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiUserId.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiFamilyId.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiPetId.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.apiFamilyMemberId.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.userImageDirectoryURL.rawValue)
    KeychainWrapper.standard.removeObject(forKey: KeychainWrapper.Key.petImageDirectoryURL.rawValue)
}
