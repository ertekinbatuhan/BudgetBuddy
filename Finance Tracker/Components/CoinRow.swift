//
//  CoinRow.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 3.09.2024.
//

import SwiftUI

// MARK: - CoinRow
// A view that displays a row for a single coin in a list, including its image, name, symbol, current price, and price change percentage.
struct CoinRow: View {
    let coin: Coin
    var imageHeight: CGFloat = 40  // Default height for the coin image
    var imageWidth: CGFloat = 40   // Default width for the coin image
    var verticalPadding: CGFloat = 8 // Vertical padding for the row
    var horizontalPadding: CGFloat = 16 // Horizontal padding for the row
    
    var body: some View {
        HStack {
            // MARK: - Coin Image
            AsyncImage(url: URL(string: coin.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()  // Show a loading indicator while the image is loading
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: imageHeight)  // Set image dimensions
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")  // Default image if loading fails
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: imageHeight)  // Set image dimensions
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()  // Handle any unknown cases
                }
            }
            
            // MARK: - Coin Details
            VStack(alignment: .leading, spacing: 2) {
                Text("\(coin.name)")  
                    .font(.headline)
                
                Text("\(coin.symbol.uppercased())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // MARK: - Coin Price and Change Percentage
            VStack(alignment: .trailing, spacing: 2) {
                Text(coin.currentPrice.toCurrency())  // Display the current price formatted as currency
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Display the price change percentage, if available
                if let changePercentage = coin.priceChangePercentage24HInCurrency {
                    // Change text color based on whether the change percentage is positive or negative
                    Text(changePercentage.toPercentage())
                        .font(.subheadline)
                        .foregroundColor(changePercentage >= 0 ? .green : .red)
                } else {
                    Text("N/A")  // Indicates price change percentage data is not available
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
    }
}
