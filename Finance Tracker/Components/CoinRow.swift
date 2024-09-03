//
//  CoinRow.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 3.09.2024.
//

import SwiftUI

// MARK: - CoinRow
// A view that displays a row for a single coin in a list.
struct CoinRow: View {
    // MARK: - Properties
    let coin: Coin
    
    // MARK: - Body
    var body: some View {
        HStack {
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
            
            VStack(alignment: .leading, spacing: 2) {
                // MARK: - Coin Name
                Text("\(coin.name)")
                    .font(.headline)
                
                // MARK: - Coin Symbol
                Text("\(coin.symbol.uppercased())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                // MARK: - Current Price
                Text(coin.currentPrice.toCurrency())
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
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}
