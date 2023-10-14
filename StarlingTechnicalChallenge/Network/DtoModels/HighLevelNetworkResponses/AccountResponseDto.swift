//
//  AccountResponseDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct AccountResponseDto: Decodable {
    let accounts: [AccountDto]
}
