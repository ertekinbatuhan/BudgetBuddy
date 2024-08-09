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
    @Published var error: CoinError?
    
    private let coinService: CoinService
    
    init(coinService: CoinService = CoinService()) {
        self.coinService = coinService
        fetchCoins()
    }
    
    var topGainers: [Coin] {
        coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
    }
    
    var topLosers: [Coin] {
        coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 < $1.priceChangePercentage24HInCurrency ?? 0 })
    }
    
    func fetchCoins() {
        coinService.fetchCoins { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coin = coins
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
