//
//  CoinViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import Foundation
import Alamofire

class CoinViewModel: ObservableObject {
    
    @Published var coin = [Coin]()
    
    init() {
        fetchCoins()
    }
    
    var topGainers: [Coin] {
        coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
    }
    
    func fetchCoins() {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en"
        
        AF.request(url, method: .get).responseDecodable(of: [Coin].self) { response in
            switch response.result {
            case .success(let coins):
                DispatchQueue.main.async {
                    self.coin = coins
                }
                
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
                
                print(coinError.localizedDescription)
            }
        }
    }
}
