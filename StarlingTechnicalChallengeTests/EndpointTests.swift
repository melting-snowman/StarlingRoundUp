//
//  EndpointTests.swift
//  StarlingTechnicalChallengeTests
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import XCTest
@testable import StarlingTechnicalChallenge

final class EndpointTests: XCTestCase {
    
    func testAccountsEndpointURL() {
        let endpoint = Endpoint.accounts
        let expectedURLString = "https://api-sandbox.starlingbank.com/api/v2/accounts"
        
        XCTAssertEqual(endpoint.url().absoluteString, expectedURLString)
    }
    
    func testGetTransactionsEndpointURL() {
        let testAccountUID = UUID().uuidString
        let testCategoryUID = UUID().uuidString
        let testDate = Date(timeIntervalSince1970: 1000000)
        let endpoint = Endpoint.getTransactions(accountUID: testAccountUID,
                                                categoryUID: testCategoryUID,
                                                startDate: testDate)
        let expectedURLString = "https://api-sandbox.starlingbank.com/api/v2/feed/account/\(testAccountUID)/category/\(testCategoryUID)?changesSince=1970-01-12T00:00:00.000Z"
        
        XCTAssertEqual(endpoint.url().absoluteString, expectedURLString)
    }
    
    func testSavingsGoalsEndpointURL() {
        let testAccountUID = UUID().uuidString
        let endpoint = Endpoint.savingsGoals(accountUID: testAccountUID)
        let expectedURLString = "https://api-sandbox.starlingbank.com/api/v2/account/\(testAccountUID)/savings-goals"

        XCTAssertEqual(endpoint.url().absoluteString, expectedURLString)
    }
    
    func testTransferToSavingsGoalURL() {
        let testAccountUID = UUID().uuidString
        let testGoalUID = UUID().uuidString
        let testTransferUID = UUID().uuidString
        
        let endpoint = Endpoint.transferToSavingsGoal(accountUID: testAccountUID,
                                                      goalUID: testGoalUID,
                                                      transferUID: testTransferUID)
        let expectedURLString = "https://api-sandbox.starlingbank.com//api/v2/account/\(testAccountUID)/savings-goals/\(testGoalUID)/add-money/\(testTransferUID)"
        
        XCTAssertEqual(endpoint.url().absoluteString, expectedURLString)
    }
}
