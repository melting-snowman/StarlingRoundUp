//
//  Endpoint.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation
import CheckoutNetwork

enum Endpoint: NetworkPath {
    
    private static let rootURL = URL(string: "https://api-sandbox.starlingbank.com/")!
    
    case accounts
    case getTransactions(accountUID: String, categoryUID: String, startDate: Date)
    case savingsGoals(accountUID: String)
    case transferToSavingsGoal(accountUID: String, goalUID: String, transferUID: String)
    
    func url() -> URL {
        switch self {
        case .accounts:
            return Self.rootURL.appending(path: "api/v2/accounts")
        case .getTransactions(let accountUID, let categoryUID, let startDate):
            let urlQueryItem = URLQueryItem(name: "changesSince", value: "\(startDate.dateFormattedForNetworkCall())T00:00:00.000Z")
            return Self.rootURL.appending(path: "api/v2/feed/account/\(accountUID)/category/\(categoryUID)").appending(queryItems: [urlQueryItem])
        case .savingsGoals(let accountUID):
            return Self.rootURL.appending(path: "api/v2/account/\(accountUID)/savings-goals")
        case .transferToSavingsGoal(let accountUID, let goalUID, let transferUID):
            return Self.rootURL.appending(path: "/api/v2/account/\(accountUID)/savings-goals/\(goalUID)/add-money/\(transferUID)")
        }
    }
}
