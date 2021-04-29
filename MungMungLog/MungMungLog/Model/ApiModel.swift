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
    case failWithDuplication = -997
    case tokenError = -996
    
}

struct CommonResponse: Codable {
    let code: Int
    let message: String?
}

struct SingleResponse<T: Codable>: Codable {
    let code: Int
    let message: String?
    let data: T?
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
    let email: String?
    let token: String?
    let user: User?
}

struct SNSLoginRequestModel: Codable {
    let provider: String
    let id: String
    let email: String
}

struct EmailJoinRequestModel: Codable {
    let email: String
    let password: String
}

struct JoinResponseModel: Codable {
    let code: Int
    let message: String?
    let email: String?
    let nickname: String?
    let userId: String?
    let token: String?
}

struct JoinInfoRequestModel: Codable {
    let email: String
    let nickname: String
    let relationship: String
    let gender: Bool
    let fileUrl: String?
}

struct InvitationCodeRequestModel: Codable {
    let code: String
    let email: String
}
