//
//  NetworkClientTests.swift
//  StarlingTechnicalChallengeTests
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import XCTest
@testable import CheckoutNetwork
@testable import CheckoutNetworkFakeClient
@testable import StarlingTechnicalChallenge

final class NetworkClientTests: XCTestCase {
    
    // MARK: Get Accounts Tests
    func testGetMainAccountRequestFormat() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        client.getAccounts() { result in
            XCTFail("Completion should not get called")
        }
        
        XCTAssertEqual(network.calledRequests.count, 1)
        let receivedRequest = network.calledRequests.first?.config.request
        XCTAssertNotNil(receivedRequest)
        XCTAssertEqual(receivedRequest?.url, Endpoint.accounts.url())
        XCTAssertEqual(receivedRequest?.httpMethod, "GET")
        XCTAssertNil(receivedRequest?.httpBody)
        
        let expectedHeader = ["Authorization": "Bearer \(GlobalConfig.userToken)"]
        XCTAssertEqual(receivedRequest?.allHTTPHeaderFields, expectedHeader)
    }
    
    func testGetMainAccountRequestFailure() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let expect = expectation(description: "Get mock network response")
        client.getAccounts() { result in
            switch result {
            case .success: XCTFail("Test should fail")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.failed)
            }
            expect.fulfill()
        }
        let networkCompletion = network.calledRequests.first?.completion as? ((Result<AccountResponseDto, Error>) -> Void)
        XCTAssertNotNil(networkCompletion)
        networkCompletion?(.failure(URLError(.timedOut)))
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetMainAccountReceivesNoAccounts() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let expect = expectation(description: "Get mock network response")
        client.getAccounts() { result in
            switch result {
            case .success(let accounts):
                XCTAssertEqual(accounts.count, 0)
            case .failure: XCTFail("Test expects a success")
            }
            expect.fulfill()
        }
        let networkCompletion = network.calledRequests.first?.completion as? ((Result<AccountResponseDto, Error>) -> Void)
        XCTAssertNotNil(networkCompletion)
        networkCompletion?(.success(AccountResponseDto(accounts: [])))
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetMainAccountReceivesAccounts() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let responseAccounts = [
            AccountDto(uid: "1234", type: .additional, defaultCategory: "asd", name: "account")
        ]
        
        let expect = expectation(description: "Get mock network response")
        client.getAccounts() { result in
            switch result {
            case .success(let accounts):
                XCTAssertEqual(accounts, responseAccounts)
            case .failure: XCTFail("Test expects a success")
            }
            expect.fulfill()
        }
        let networkCompletion = network.calledRequests.first?.completion as? ((Result<AccountResponseDto, Error>) -> Void)
        XCTAssertNotNil(networkCompletion)
        networkCompletion?(.success(AccountResponseDto(accounts: responseAccounts)))
        
        waitForExpectations(timeout: 1)
    }
    
    // MARK: Get Transactions Tests
    func testGetTransactionsRequestFormat() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let testAccountDto = AccountDto(uid: "asdsdf", type: .primary, defaultCategory: "sbfrge", name: "bdfthre")
        client.getTransactions(for: testAccountDto) { result in
            XCTFail("Completion should not get called")
        }
        
        XCTAssertEqual(network.calledRequests.count, 1)
        let receivedRequest = network.calledRequests.first?.config.request
        XCTAssertNotNil(receivedRequest)
        let expectedURL = Endpoint.getTransactions(accountUID: testAccountDto.uid, categoryUID: testAccountDto.defaultCategory, startDate: Date(timeIntervalSinceNow: -2592000)).url()
        XCTAssertEqual(receivedRequest?.url, expectedURL)
        XCTAssertEqual(receivedRequest?.httpMethod, "GET")
        XCTAssertNil(receivedRequest?.httpBody)
        
        let expectedHeader = ["Authorization": "Bearer \(GlobalConfig.userToken)"]
        XCTAssertEqual(receivedRequest?.allHTTPHeaderFields, expectedHeader)
    }
    
    func testGetTransactionsRequestFailure() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let expect = expectation(description: "Get mock network response")
        let testAccountDto = AccountDto(uid: "asdsdf", type: .primary, defaultCategory: "sbfrge", name: "bdfthre")
        client.getTransactions(for: testAccountDto) { result in
            switch result {
            case .success: XCTFail("Test should fail")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.failed)
            }
            expect.fulfill()
        }
        let networkCompletion = network.calledRequests.first?.completion as? ((Result<TransactionListResponseDto, Error>) -> Void)
        XCTAssertNotNil(networkCompletion)
        networkCompletion?(.failure(URLError(.timedOut)))
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetTransactionsSuccess() {
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let responseTransactions = [
            FeedItemDto(uid: "ascfa", categoryUID: "bhter", amount: .init(currency: .gbp, minorUnits: 32236), sourceAmount: .init(currency: .gbp, minorUnits: 32236), direction: .outbound, updatedAt: nil, transactionTime: nil, settlementTime: nil, retryAllocationUntilTime: nil, status: .settled, transactingApplicationUserUid: nil, roundUp: nil, source: nil, sourceSubType: nil)
        ]
        
        let expect = expectation(description: "Get mock network response")
        let testAccountDto = AccountDto(uid: "asdsdf", type: .primary, defaultCategory: "sbfrge", name: "bdfthre")
        client.getTransactions(for: testAccountDto) { result in
            switch result {
            case .success(let transactions):
                XCTAssertEqual(transactions, responseTransactions)
            case .failure: XCTFail("Test expects a success")
            }
            expect.fulfill()
        }
        let networkCompletion = network.calledRequests.first?.completion as? ((Result<TransactionListResponseDto, Error>) -> Void)
        XCTAssertNotNil(networkCompletion)
        networkCompletion?(.success(TransactionListResponseDto(feedItems: responseTransactions)))
        
        waitForExpectations(timeout: 1)
    }
    
}
