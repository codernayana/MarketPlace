//
//  DashboardViewModelTests.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import XCTest
@testable import Marketplace

final class DashboardViewModelTests: XCTestCase {
    
    func test_startCountdown_triggersCountdownAndHandler() async throws {
        // Arrange
        let mockContext = MockCountdownContext()
        let viewModel = DashboardViewModel(context: mockContext)

        let expectation = XCTestExpectation(description: "Countdown update called")

        viewModel.onCountdownUpdate = { text in
            XCTAssertEqual(text, "Test update")
            expectation.fulfill()
        }

        // Act
        viewModel.startCountdown()

        // Wait for `Task {}` to execute
        try await Task.sleep(nanoseconds: 200_000_000)

        // Simulate the countdown callback
        mockContext.capturedHandler?("Test update")

        // Assert with new Swift 6 way
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertTrue(mockContext.startCalled)
    }

    func test_stopCountdown_callsStopOnContext() async throws {
        // Arrange
        let mockContext = MockCountdownContext()
        let viewModel = DashboardViewModel(context: mockContext)

        // Act
        viewModel.stopCountdown()

        // Wait a bit for the async Task
        try await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertTrue(mockContext.stopCalled)
    }
}
