//
//  TransactionStatus.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

enum TransactionStatus: String, Codable {
    case upcoming = "UPCOMING"
    case pending = "PENDING"
    case reversed = "REVERSED"
    case settled = "SETTLED"
    case declined = "DECLINED"
    case refunded = "REFUNDED"
    case retrying = "RETRYING"
    case check = "ACCOUNT_CHECK"
}
