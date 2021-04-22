//
//  UserModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/22.
//

import Foundation

struct User: Codable {
    let nickname: String
    let relationship: String
    let gender: Bool
    let fileUrl: String?
    let familyId: Int?
    let family: Family?
}
