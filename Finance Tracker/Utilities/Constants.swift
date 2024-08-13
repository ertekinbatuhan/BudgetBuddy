//
//  Constants.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 9.08.2024.
//

import Foundation

struct Constants {
    struct URLs {
        static let coinURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en"
    }
}
