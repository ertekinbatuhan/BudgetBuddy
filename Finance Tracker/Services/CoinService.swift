//
//  CoinService.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 9.08.2024.
//

import Foundation
import Alamofire

class CoinService {
    func fetchCoins(completion: @escaping (Result<[Coin], CoinError>) -> Void) {
        let url = Constants.URLs.coinURL
        
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
