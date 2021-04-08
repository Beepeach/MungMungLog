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
    }
    
    static var emailLogin: String {
        return "\(host)\(Path.emailLogin.rawValue)"
    }
    
    static var snsLogin: String {
        return "\(host)\(Path.snsLogin.rawValue)"
    }
    
    static var emailJoin: String{
        return "\(host)\(Path.emailJoin.rawValue)"
    }
    
    static var joinWithInfo: String{
        return "\(host)\(Path.joinWithInfo.rawValue)"
    }
}
