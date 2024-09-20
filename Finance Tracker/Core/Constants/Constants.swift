//
//  Constants.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 7.09.2024.
//

import Foundation

struct Constants {
    struct API {
        // MARK: - Base URL
        static let baseURL = "https://api.coingecko.com/api/v3"
        
        // MARK: - Endpoints
        struct Endpoints {
            static let coinsMarkets = "/coins/markets"
        }
        
        // MARK: - URL Construction
        /// Creates a URL for fetching coin data.
        /// - Parameters:
        ///   - vsCurrency: Currency for data
        ///   - order: Result order
        ///   - perPage: Results per page
        ///   - page: Page number
        ///   - sparkline: Include sparkline data
        ///   - priceChangePercentage: Price change period
        ///   - locale: Locale for results
        /// - Returns: Constructed URL string
        static func coinURL(
            vsCurrency: String = "usd",
            order: String = "market_cap_desc",
            perPage: Int = 100,
            page: Int = 1,
            sparkline: Bool = true,
            priceChangePercentage: String = "24h",
            locale: String = "en"
        ) -> String {
            return "\(baseURL)\(Endpoints.coinsMarkets)?vs_currency=\(vsCurrency)&order=\(order)&per_page=\(perPage)&page=\(page)&sparkline=\(sparkline)&price_change_percentage=\(priceChangePercentage)&locale=\(locale)"
        }
    }
}
