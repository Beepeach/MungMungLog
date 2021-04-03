//
//  ApiModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/03.
//

import Foundation

enum Statuscode: Int {
    case ok = 200
    case notFound = 404
    case unKnown = -999
    case fail = -998
    
}

struct CommonResponse: Codable {
    let code: Int
    let message: String?
}

struct SingleResponse<T: Codable>: Codable {
    let code: Int
    let message: String?
    let data: T
}

struct ListResponse<T: Codable>: Codable {
    let code: Int
    let message: String?
    let list: [T]
}

struct EmailLoginRequestModel: Codable {
    let email: String
    let password: String
}

struct LoginResponseModel: Codable {
    let code: Int
    let message: String?
    let userId: String?
    let token: String?
}

struct SNSLoginRequestModel: Codable {
    let provider: String
    let id: String
    let email: String
}






