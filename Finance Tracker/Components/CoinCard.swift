//
//  CoinCard.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 3.09.2024.
//

import SwiftUI

// MARK: - CoinCard
// A view that displays information about a single coin.
struct CoinCard: View {
    // MARK: - Properties
    let coin: Coin
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 5) {
            // MARK: - Coin Image
            AsyncImage(url: URL(string: coin.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Coin Symbol
            Text("\(coin.symbol.uppercased())")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // MARK: - Price Change Percentage
            if let changePercentage = coin.priceChangePercentage24HInCurrency {
                Text(changePercentage.toPercentage())
                    .font(.subheadline)
                    .foregroundColor(changePercentage >= 0 ? .green : .red)
            } else {
                Text("N/A")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(width: 100)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
