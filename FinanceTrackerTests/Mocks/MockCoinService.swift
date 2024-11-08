//
//  MockCoinService.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 20.09.2024.
//

@testable import Finance_Tracker

class MockCoinService: CoinServiceProtocol {
    var shouldReturnError = false
    var mockCoins: [Coin] = []
    
    func fetchCoins() async throws -> [Coin] {
        if shouldReturnError {
            throw CoinError.networkError("Test Error")
        } else {
            return mockCoins
        }
    }
}
