//
//  UnitTests.swift
//  UnitTests
//
//  Created by Batuhan Berk Ertekin on 20.09.2024.
//

import XCTest
@testable import Finance_Tracker

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
    
    func testFetchCoins_whenAPISuccess_showsCoins() {
        // Given: Mock coin data is prepared
        let mockCoins = createMockCoins()
        mockService.mockCoins = mockCoins
        let expectation = self.expectation(description: "Fetch coins")
        
        // When: Attempt to fetch coins
        viewModel.fetchCoins()
        
        // Then: Verify the result after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.coin)
            XCTAssertEqual(self.viewModel.coin.count, 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCoins_whenAPIError_returnsError() {
        // Given: Service is set to return an error
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch coins failure")
        
        // When: Attempt to fetch coins
        viewModel.fetchCoins()
        
        // Then: Verify the result after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.coin.count, 0)
            XCTAssertEqual(self.viewModel.error?.localizedDescription, CoinError.networkError("Test Error").localizedDescription)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPerformanceExample() throws {
        measure {
            // Perform operations to measure
        }
    }
}
