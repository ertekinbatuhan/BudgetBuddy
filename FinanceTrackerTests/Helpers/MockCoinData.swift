//
//  File.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 20.09.2024.
//

@testable import Finance_Tracker

 func createMockCoins() -> [Coin] {
    return [
        Coin(
            id: "1",
            symbol: "BTC",
            name: "Bitcoin",
            image: "bitcoin.png",
            currentPrice: 27000.0,
            marketCapRank: 1,
            marketCap: 500000000000,
            fullyDilutedValuation: 600000000000,
            totalVolume: 1000000000,
            high24H: 28000.0,
            low24H: 26000.0,
            priceChange24H: 500.0,
            priceChangePercentage24H: 1.85,
            marketCapChange24H: 1000000000,
            marketCapChangePercentage24H: 2.0,
            circulatingSupply: 19000000,
            totalSupply: 21000000,
            maxSupply: 21000000,
            ath: 69000.0,
            athChangePercentage: -60.87,
            athDate: "2021-11-10T00:00:00.000Z",
            atl: 67.0,
            atlChangePercentage: 40000.0,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2024-09-20T12:00:00Z",
            priceChangePercentage24HInCurrency: 1.85
        ),
        Coin(
            id: "2",
            symbol: "ETH",
            name: "Ethereum",
            image: "ethereum.png",
            currentPrice: 1800.0,
            marketCapRank: 2,
            marketCap: 300000000000,
            fullyDilutedValuation: 400000000000,
            totalVolume: 500000000,
            high24H: 1850.0,
            low24H: 1750.0,
            priceChange24H: -50.0,
            priceChangePercentage24H: -2.7,
            marketCapChange24H: -100000000,
            marketCapChangePercentage24H: -0.5,
            circulatingSupply: 120000000,
            totalSupply: nil,
            maxSupply: nil,
            ath: 4800.0,
            athChangePercentage: -62.5,
            athDate: "2021-11-10T00:00:00.000Z",
            atl: 0.4,
            atlChangePercentage: 450000.0,
            atlDate: "2015-10-20T00:00:00.000Z",
            lastUpdated: "2024-09-20T12:00:00Z",
            priceChangePercentage24HInCurrency: -2.7
        )
    ]
}
