//
//  CoinViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import Foundation
import Alamofire

// MARK: - Protocol
// Protocol defining the contract for a ViewModel managing coin data.
protocol CoinViewModelProtocol: ObservableObject {
    var coin: [Coin] { get }
    var error: CoinError? { get }
    var topEarners: [Coin] { get }
    var topLosers: [Coin] { get }
    func fetchCoins()
}

// MARK: - CoinViewModel
final class CoinViewModel: ObservableObject, CoinViewModelProtocol {
    
    // MARK: - Published Properties
    @Published var coin = [Coin]()
    @Published var error: CoinError?
    
    // MARK: - Private Properties
    private let coinService: CoinServiceProtocol
    private var sortedCoins: [Coin] = []
    
    // MARK: - Initialization
    init(coinService: CoinServiceProtocol) {
        self.coinService = coinService
    }
    
    // MARK: - Computed Properties
    var topEarners: [Coin] {
        sortedCoins.filter { $0.priceChangePercentage24HInCurrency ?? 0 > 0 }
    }
    
    var topLosers: [Coin] {
        sortedCoins.filter { $0.priceChangePercentage24HInCurrency ?? 0 < 0 }
    }
    
    // MARK: - Methods
    func fetchCoins() {
        coinService.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coin = coins
                    self?.sortedCoins = coins.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
