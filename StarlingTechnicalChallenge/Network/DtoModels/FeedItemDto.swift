//
//  FeedItemDto.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

struct FeedItemDto: Decodable, Equatable {
    let uid: String
    let categoryUID: String
    let amount: TransactionAmountDto
    let sourceAmount: TransactionAmountDto
    let direction: TransactionDirection
    let updatedAt: String?
    let transactionTime: String?
    let settlementTime: String?
    let retryAllocationUntilTime: String?
    let status: TransactionStatus
    let transactingApplicationUserUid: String?
    let roundUp: AssociatedFeedRoundUp?
    
    // TODO: Convert to Enum! Too many cases for take home project
    let source: String?
    // TODO: Convert to Enum! Too many cases for take home project
    let sourceSubType: String?
    
    private enum CodingKeys: String, CodingKey {
        case uid = "feedItemUid"
        case categoryUID = "categoryUid"
        case amount
        case sourceAmount
        case direction
        case updatedAt
        case transactionTime
        case settlementTime
        case retryAllocationUntilTime
        case status
        case transactingApplicationUserUid
        case roundUp
        case source
        case sourceSubType
    }
}
