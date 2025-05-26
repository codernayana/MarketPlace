//
//  MockCountdownContext.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

@testable import Marketplace
import XCTest

final class MockCountdownContext: CountdownContext {
    var startCalled = false
    var stopCalled = false
    var capturedHandler: ((String) -> Void)?

    func start(countdownTo date: Date, update handler: @escaping (String) -> Void) async {
        startCalled = true
        capturedHandler = handler
    }

    func stop() async {
        stopCalled = true
    }
}
