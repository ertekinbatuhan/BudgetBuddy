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
    
    func fetchCoins(completion: @escaping (Result<[Coin], CoinError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError("Test Error")))
        } else {
            completion(.success(mockCoins))
        }
    }
}
