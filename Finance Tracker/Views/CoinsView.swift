//
//  CoinsView.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 26.07.2024.
//

import SwiftUI

struct CoinsView: View {
    @ObservedObject private var coinViewModel = CoinViewModel()

    init() {
        NavigationAppearance.configure()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    Text("Top Gainers")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if !coinViewModel.topEarners.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 20) {
                                ForEach(coinViewModel.topEarners) { coin in
                                    VStack {
                                        AsyncImage(url: URL(string: coin.image)) { coin in
                                            switch coin {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(8)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(8)
                                            default:
                                                EmptyView()
                                            }
                                        }
                                        .padding(.horizontal)

                                        Text("\(coin.symbol.uppercased())")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

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
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 150)
                    } else {
                        ProgressView()
                            .padding(.top, 20)
                    }

                    Text("All Coins")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if coinViewModel.coin.isEmpty {
                        ProgressView()
                            .padding(.top, 20)
                    } else {
                        ForEach(coinViewModel.coin) { coin in
                            HStack {
                                AsyncImage(url: URL(string: coin.image)) { coin in
                                    switch coin {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(8)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(8)
                                    default:
                                       EmptyView()
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(coin.name)")
                                        .font(.headline)

                                    Text("\(coin.symbol.uppercased())")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(coin.currentPrice.toCurrency())
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

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
                }
                .padding(.horizontal)
            }
            .navigationTitle("Live Prices")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                coinViewModel.fetchCoins()
            }
        }
    }
}

#Preview {
    CoinsView()
}

