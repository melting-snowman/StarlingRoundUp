//
//  SavingGoalsResponseDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct SavingGoalsResponseDto: Decodable, Equatable {
    let savingsGoalList: [SavingGoalDto]
}
