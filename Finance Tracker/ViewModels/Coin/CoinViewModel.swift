//
//  CoinViewModel.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import Foundation

// MARK: - Protocol
// Protocol defining the contract for a ViewModel managing coin data.
protocol CoinViewModelProtocol: ObservableObject {
    var coin: [Coin] { get }
    var error: CoinError? { get }
    var topEarners: [Coin] { get }
    var topLosers: [Coin] { get }
    func fetchCoins() async
}

// MARK: - CoinViewModel
@MainActor
final class CoinViewModel: ObservableObject,CoinViewModelProtocol {
    
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
    func fetchCoins() async {
        do {
            let coins = try await coinService.fetchCoins()
            self.coin = coins
            self.sortedCoins = coins.sorted(by: { $0.priceChangePercentage24HInCurrency ?? 0 > $1.priceChangePercentage24HInCurrency ?? 0 })
            self.error = nil
        } catch let coinError as CoinError {
            self.error = coinError
        } catch {
            self.error = .decodingError
        }
    }
}
