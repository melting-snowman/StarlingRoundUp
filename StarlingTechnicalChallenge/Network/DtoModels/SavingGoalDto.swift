//
//  SavingGoalDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct SavingGoalDto: Decodable, Equatable {
    let uid: String
    let name: String
    let target: TransactionAmountDto
    let totalSaved: TransactionAmountDto
    let savedPercentage: Int
    let state: SavingGoalState
    
    private enum CodingKeys: String, CodingKey {
        case uid = "savingsGoalUid"
        case name
        case target
        case totalSaved
        case savedPercentage
        case state
    }
}
