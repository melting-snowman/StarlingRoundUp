//
//  AccountTypeDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

enum AccountTypeDto: String, Decodable, Equatable {
    case primary = "PRIMARY"
    case additional = "ADDITIONAL"
    case load = "LOAN"
    case deposit = "FIXED_TERM_DEPOSIT"
}
