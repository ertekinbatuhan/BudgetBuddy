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
                LazyVStack(spacing: 10) {
                    Text("TOPGAINERS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if !coinViewModel.topGainers.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(coinViewModel.topGainers) { coin in
                                    VStack(spacing: 5) {
                                        AsyncImage(url: URL(string: coin.image)) { coin in
                                            switch coin {
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
                                            default:
                                                EmptyView()
                                            }
                                        }

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
                                    .padding(.horizontal, 12)
                                    .frame(width: 100)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 130)
                    } else {
                        ProgressView()
                            .padding(.top, 10)
                    }

                    Text("TOPLOSERS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if !coinViewModel.topLosers.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(coinViewModel.topLosers) { coin in
                                    VStack(spacing: 5) {
                                        AsyncImage(url: URL(string: coin.image)) { coin in
                                            switch coin {
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
                                            default:
                                                EmptyView()
                                            }
                                        }

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
                                    .padding(.horizontal, 12)
                                    .frame(width: 100) 
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 130)
                    } else {
                        ProgressView()
                            .padding(.top, 10)
                    }

                    Text("ALLCOINS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if coinViewModel.coin.isEmpty {
                        ProgressView()
                            .padding(.top, 10)
                    } else {
                        ForEach(coinViewModel.coin) { coin in
                            HStack(spacing: 10) {
                                AsyncImage(url: URL(string: coin.image)) { coin in
                                    switch coin {
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
                                    default:
                                       EmptyView()
                                    }
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(coin.name)")
                                        .font(.headline)

                                    Text("\(coin.symbol.uppercased())")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 2) {
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
            .navigationTitle("LIVEPRICES")
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

