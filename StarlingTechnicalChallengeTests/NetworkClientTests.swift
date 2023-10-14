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
    
    // MARK: Get Main Account Tests
    func testGetMainAccountRequestFormat() {
        let testAccountUID = UUID().uuidString
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        client.getMainAccount(for: testAccountUID) { result in
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
        let testAccountUID = UUID().uuidString
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let expect = expectation(description: "Get mock network response")
        client.getMainAccount(for: testAccountUID) { result in
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
        let testAccountUID = UUID().uuidString
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let expect = expectation(description: "Get mock network response")
        client.getMainAccount(for: testAccountUID) { result in
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
        let testAccountUID = UUID().uuidString
        let network = CheckoutNetworkFakeClient()
        let client = NetworkClient(clientInterface: network)
        
        let responseAccounts = [
            AccountDto(uid: "1234", type: .additional, defaultCategory: "asd", name: "account")
        ]
        
        let expect = expectation(description: "Get mock network response")
        client.getMainAccount(for: testAccountUID) { result in
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
    
}
