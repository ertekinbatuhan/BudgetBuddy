//
//  CoinService.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 1.09.2024.
//

import Foundation
import Alamofire

// MARK: - CoinServiceProtocol
/// Protocol defining the contract for a service that fetches coin data.
protocol CoinServiceProtocol {
    /// Fetches coins data from an API asynchronously.
    /// - Returns: An array of `Coin` objects if successful.
    /// - Throws: A `CoinError` if the request fails.
    func fetchCoins() async throws -> [Coin]
}

// MARK: - CoinService
/// A service responsible for fetching coin data from the API.
final class CoinService: CoinServiceProtocol {
    
    // MARK: - Methods
    /// Fetches coins from the API using async/await.
    /// - Returns: An array of `Coin` objects on successful response.
    /// - Throws: A `CoinError` for different error cases (network, invalid response, decoding).
    func fetchCoins() async throws -> [Coin] {
        let url = Constants.API.coinURL()
        
        do {
            // Fetch and decode coin data asynchronously
            let response = try await AF.request(url, method: .get)
                .serializingDecodable([Coin].self)
                .value
            return response
        } catch let error as AFError {
            // MARK: - Alamofire Error Handling
            // Convert Alamofire errors to CoinError types
            if case .responseValidationFailed(reason: .dataFileReadFailed) = error {
                throw CoinError.invalidResponse
            } else {
                throw CoinError.networkError(error.localizedDescription)
            }
        } catch {
            // MARK: - Other Error Handling
            // Handle non-Alamofire errors, such as decoding errors
            throw CoinError.decodingError
        }
    }
}
