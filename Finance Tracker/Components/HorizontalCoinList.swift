//
//  HorizontalCoinListView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 3.09.2024.
//

import SwiftUI

// MARK: - HorizontalCoinList
// A view that displays a horizontally scrollable list of coin cards.
struct HorizontalCoinList: View {
    // MARK: - Properties
    let coins: [Coin]
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            // MARK: - Coin Cards
            LazyHStack(spacing: 15) {
                ForEach(coins) { coin in
                    CoinCard(coin: coin)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 130)
    }
}
