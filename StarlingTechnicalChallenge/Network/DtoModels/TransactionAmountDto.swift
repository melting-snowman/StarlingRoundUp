//
//  TransactionAmountDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct TransactionAmountDto: Codable, Equatable {
    let currency: CurrencyDto
    let minorUnits: Int
}
