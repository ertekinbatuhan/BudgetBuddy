//
//  CoinEreror.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import Foundation

// MARK: - CoinError
// Enum for representing different types of errors related to coin data fetching.
enum CoinError: Error {
    case networkError(String)
    case decodingError
    case invalidResponse
    
    // MARK: - Computed Properties
    var localizedDescription: String {
        switch self {
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError:
            return "Failed to decode data."
        case .invalidResponse:
            return "The response from the server was invalid."
        }
    }
}
