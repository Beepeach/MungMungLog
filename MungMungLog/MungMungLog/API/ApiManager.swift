//
//  ApiManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/03.
//

import Foundation
import SwiftKeychainWrapper

enum ApiError: Error {
    case invalidURL
    case failed(Int)
    case emptyData
}

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    enum Path: String {
        case emailLogin = "/api/login/email"
        case snsLogin = "/api/login/sns"
        case emailJoin = "/api/join/email"
        case joinWithInfo = "/api/join/info"
        case createPet = "/api/pet"
        case getPetList = "/api/pet/list"
        case requestInvitation = "/api/family/invitation"
    }
    
    static var emailLogin: String {
        return "\(host)\(Path.emailLogin.rawValue)"
    }
    
    static var snsLogin: String {
        return "\(host)\(Path.snsLogin.rawValue)"
    }
    
    static var emailJoin: String {
        return "\(host)\(Path.emailJoin.rawValue)"
    }
    
    static var joinWithInfo: String {
        return "\(host)\(Path.joinWithInfo.rawValue)"
    }
    
    static var createPet: String {
        return "\(host)\(Path.createPet.rawValue)"
    }
    
    static var getPetList: String {
        let familyId = KeychainWrapper.standard.string(forKey: "api-familyId") ?? "-1"
        
        return "\(host)\(Path.getPetList.rawValue)" + "/\(familyId)"
    }
    
    static var requestInvitation: String {
        return "\(host)\(Path.requestInvitation.rawValue)"
    }
    
    
}
