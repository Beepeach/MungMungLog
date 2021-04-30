//
//  FamilyModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/14.
//

import Foundation

struct FamilyDto: Codable {
    let familyId: Int
    let invitationCode: String
    let codeExpirationDate: Double
    let familyMembers: [FamilyMemberDto]?
    let pets: [PetDto]
}
