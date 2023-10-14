//
//  AssociatedFeedRoundUp.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct AssociatedFeedRoundUp: Decodable, Equatable {
    let goalCategoryUid: String
    let amount: TransactionAmountDto
}
