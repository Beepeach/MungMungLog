//
//  FamilyMemberModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/14.
//

import Foundation

struct FamilyMemberDto: Codable {
    let isMaster: Bool
    let status: Int
    let userId: String
    let familyId: Int?
}
