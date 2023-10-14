//
//  AccountViewModel.swift
//  StarlingTechnicalChallenge
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import Foundation

protocol AccountViewModelDelegate: AnyObject {
    func receivedRoundUp(_ roundUpAmount: Int)
}

// TODO: Test!! We can test via injecting a FakeNetworkClient and adding preset network responses !!!
final class AccountViewModel {
 
    var delegate: AccountViewModelDelegate?
    
    private(set) var isLoading = false
    
    private var roundUpAmount: Int = 0
    private let networkClient: NetworkClientInterface
    
    init(networkClient: NetworkClientInterface = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    /// Will retrieve the accounts for the user, followed by the transactions for the main account, ending with calculating the RoundUp and using delegate to pass value back
    func retrieveRoundUpAmount() {
        isLoading = true
        networkClient.getAccounts { [weak self] result in
            switch result {
            case .success(let accounts):
                guard !accounts.isEmpty,
                      let selectedAccount = accounts.first(where: { $0.type == .primary }) ??
                        accounts.first(where: { $0.type == .additional }) else {
                    // TODO: Handle lack of accounts. Case not covered in sample project
                    return
                }
                self?.retrieveTransactions(for: selectedAccount)
            case .failure:
                // TODO: Handle failure. Nothing being covered at the moment
                break
            }
        }
    }
    
    private func retrieveTransactions(for account: AccountDto) {
        networkClient.getTransactions(for: account) { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.processRoundUp(from: transactions)
            case .failure:
                // TODO: Handle failure. Nothing being covered at the moment
                break
            }
        }
    }
    
    private func processRoundUp(from transactions: [FeedItemDto]) {
        // Business logic for what makes a transaction valid for roundup
        // TODO: How do we make sure transactions don't get rounded up multiple times??? Use FeedItem.roudUp item?
        let validTransactions = transactions.filter { $0.direction == .outbound && $0.status == .settled && $0.amount.currency == .gbp }
        let transactionValues: [Double] = validTransactions.compactMap { Double($0.amount.minorUnits) / 100 }
        
        let roundUpAmount = transactionValues.reduce(0, { sum, value in
            let roundedUpValue = value.rounded(.up)
            let delta = ((roundedUpValue - value) * 100).rounded()
            return sum + delta
        })
        self.roundUpAmount = Int(roundUpAmount)
        
        DispatchQueue.main.async {
            self.delegate?.receivedRoundUp(self.roundUpAmount)
        }
    }
}
