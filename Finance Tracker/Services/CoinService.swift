//
//  CoinService.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import Foundation
import Alamofire

//MARK: - Protocol
protocol CoinServiceProtocol {
    func fetchCoins(completion: @escaping (Result<[Coin], CoinError>) -> Void)
}

// MARK: - CoinService
// Implements CoinServiceProtocol to fetch coin data.
class CoinService : CoinServiceProtocol {
    
    // MARK: - Singleton Instance
    static let shared = CoinService()
    
    // Private initializer to prevent multiple instances.
    private init() {}
    
    // MARK: - fetchCoins
    // Fetches coin data from the API and handles the response.
    func fetchCoins(completion: @escaping (Result<[Coin], CoinError>) -> Void) {
        let url = Constants.API.coinURL()
        
        AF.request(url, method: .get).responseDecodable(of: [Coin].self) { response in
            switch response.result {
            case .success(let coins):
                completion(.success(coins))
                
            case .failure(let error):
                let coinError: CoinError
                
                if let afError = error.asAFError {
                    switch afError {
                    case .responseValidationFailed(reason: .dataFileReadFailed):
                        coinError = .invalidResponse
                    default:
                        coinError = .networkError(error.localizedDescription)
                    }
                } else {
                    coinError = .decodingError
                }
                
                completion(.failure(coinError))
            }
        }
    }
}
