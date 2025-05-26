import XCTest
@testable import Marketplace

// MARK: - CountdownContext Tests

final class CountdownTests: XCTestCase {

    func test_start_callsUpdateClosure_withFormattedTime() async throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Update closure called")
        expectation.expectedFulfillmentCount = 1

        let testFormatter = DateComponentsFormatter()
        testFormatter.allowedUnits = [.second]
        testFormatter.unitsStyle = .abbreviated // e.g., "5s"

        let countdown = Countdown(updateInterval: 0.1, formatter: testFormatter)

        // Set a date 5 seconds in the future
        let targetDate = Date().addingTimeInterval(5)

        var receivedText: String?

        // Act
        await countdown.start(countdownTo: targetDate) { text in
            receivedText = text
            expectation.fulfill()
        }

        // Wait for 1 update to occur
        await fulfillment(of: [expectation], timeout: 1.0)

        // Assert
        XCTAssertNotNil(receivedText)
        XCTAssertTrue(receivedText!.contains("s"), "Expected abbreviated seconds format, got: \(receivedText!)")
    }

    func test_stop_cancelsTask_noFurtherUpdates() async throws {
        // Arrange
        let countdown = Countdown(updateInterval: 0.1)
        let targetDate = Date().addingTimeInterval(5)

        let updateExpectation = XCTestExpectation(description: "Update closure should be called once")
        updateExpectation.expectedFulfillmentCount = 1

        var updateCount = 0

        // Act
        await countdown.start(countdownTo: targetDate) { _ in
            updateCount += 1
            if updateCount == 1 {
                updateExpectation.fulfill()
            }
        }

        // Wait for first update
        await fulfillment(of: [updateExpectation], timeout: 1.0)

        // Stop countdown
        countdown.stop()

        // Wait longer to confirm no further updates happen
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

        // Assert
        XCTAssertEqual(updateCount, 1, "Expected exactly one update after stop")
    }
}
