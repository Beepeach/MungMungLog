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
    }
    
    static var snsLogin: String {
        return "\(host)\(Path.snsLogin.rawValue)"
    }
    
    
}
