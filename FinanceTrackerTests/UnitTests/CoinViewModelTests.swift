//
//  UnitTests.swift
//  UnitTests
//
//  Created by Batuhan Berk Ertekin on 20.09.2024.
//

import XCTest
@testable import Finance_Tracker

@MainActor
final class Finance_TrackerUnitTests: XCTestCase {
    
    var viewModel: CoinViewModel!
    var mockService: MockCoinService!
    
    override func setUpWithError() throws {
        mockService = MockCoinService()
        viewModel = CoinViewModel(coinService: mockService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    // MARK: - Tests
    
    func testFetchCoins_whenAPISuccess_showsCoins() async throws {
        // Given: Mock coin data is prepared
        let mockCoins = createMockCoins()
        mockService.mockCoins = mockCoins
        
        // When: Attempt to fetch coins
        await viewModel.fetchCoins()
        
        // Then: Verify the result
        XCTAssertNotNil(viewModel.coin)
        XCTAssertEqual(viewModel.coin.count, 2)
    }
    
    func testFetchCoins_whenAPIError_returnsError() async throws {
        // Given: Service is set to return an error
        mockService.shouldReturnError = true
        
        // When: Attempt to fetch coins
        await viewModel.fetchCoins()
        
        // Then: Verify the result
        XCTAssertEqual(viewModel.coin.count, 0)
        XCTAssertEqual(viewModel.error?.localizedDescription, CoinError.networkError("Test Error").localizedDescription)
    }
    
    func testPerformanceExample() throws {
        measure {
            // Perform operations to measure
        }
    }
}
