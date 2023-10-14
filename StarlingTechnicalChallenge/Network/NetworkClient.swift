//
//  NetworkClient.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation
import CheckoutNetwork

final class NetworkClient {
    
    private let client: CheckoutClientInterface
    
    init(clientInterface: CheckoutClientInterface = CheckoutNetworkClient()) {
        self.client = clientInterface
    }
    
    /// Retrieve accounts for the current user. GlobalConfig token and user ID are used
    func getAccounts(completionHandler: @escaping ((Result<[AccountDto], NetworkError>) -> Void)) {
        let requestConfiguration = try! RequestConfiguration(path: Endpoint.accounts,
                                                             httpMethod: .get,
                                                             customHeaders: authenticationHeader())
        client.runRequest(with: requestConfiguration) { (response: Result<AccountResponseDto, Error>) in
            switch response {
            case .failure:
                completionHandler(.failure(.failed))
            case .success(let response):
                completionHandler(.success(response.accounts))
            }
        }
    }
    
    
    private func authenticationHeader() -> [String: String] {
        ["Authorization": "Bearer \(GlobalConfig.userToken)"]
    }
}
