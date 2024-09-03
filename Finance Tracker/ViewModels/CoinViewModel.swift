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
// ViewModel for managing coin data and interactions.
class CoinViewModel: ObservableObject, CoinViewModelProtocol{
    
    // MARK: - Published Properties
    @Published var coin = [Coin]()
    @Published var error: CoinError?
    
    // MARK: - Private Properties
    private let coinService: CoinServiceProtocol
    
    // MARK: - Initialization
    // Initialization logic and setup here.
    init(coinService: CoinServiceProtocol = CoinService()) {
        self.coinService = coinService
        fetchCoins()
    }
    
    // MARK: - Computed Properties
    // Computed properties for sorting and filtering coin data.
    var topEarners: [Coin] {
        coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
    }
    
    var topLosers: [Coin] {
        coin.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 < $1.priceChangePercentage24HInCurrency ?? 0 })
    }
    
    // MARK: - Methods
    // Methods for fetching coin data and handling results.
    func fetchCoins() {
        coinService.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coin = coins
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
