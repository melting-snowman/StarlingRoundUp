//
//  SavingGoalState.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

enum SavingGoalState: String, Decodable {
    case creating = "CREATING"
    case active = "ACTIVE"
    case archiving = "ARCHIVING"
    case archived = "ARCHIVED"
    case restoring = "RESTORING"
    case pending = "PENDING"
}
