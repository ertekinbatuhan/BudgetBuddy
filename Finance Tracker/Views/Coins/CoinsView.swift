//
//  CoinsView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import SwiftUI

struct CoinsView: View {
    
    // MARK: - Properties
    @ObservedObject private var coinViewModel: CoinViewModel
    
    // MARK: - Initialization
    init(coinService: CoinServiceProtocol) {
        self.coinViewModel = CoinViewModel(coinService: coinService)
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 10) {
                    SectionHeader(title: LocalizedStringKey("COINS_TOP_GAINERS"))
                    
                    if !coinViewModel.coin.isEmpty {
                        HorizontalCoinList(coins: coinViewModel.topEarners)
                    } else {
                        ProgressView()
                            .padding(.top, 10)
                    }
                    
                    SectionHeader(title: LocalizedStringKey("COINS_TOP_LOSERS"))
                    
                    if !coinViewModel.topLosers.isEmpty {
                        HorizontalCoinList(coins: coinViewModel.topLosers)
                    } else {
                        ProgressView()
                            .padding(.top, 10)
                    }
                    
                    SectionHeader(title: LocalizedStringKey("COINS_ALL_COINS"))
                    
                    ForEach(coinViewModel.coin) { coin in
                        CoinRow(coin: coin)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("COINS_LIVE_PRICES")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                coinViewModel.fetchCoins()
            }
        }
    }
}

#Preview {
    CoinsView(coinService: CoinService())
}
