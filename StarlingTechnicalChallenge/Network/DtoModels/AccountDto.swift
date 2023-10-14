//
//  AccountDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct AccountDto: Decodable, Equatable {
    let uid: String
    let type: AccountTypeDto
    let defaultCategory: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case uid = "accountUid"
        case type = "accountType"
        case defaultCategory
        case name
    }
}
