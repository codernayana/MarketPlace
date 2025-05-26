//
//  MarketplaceViewModelTests.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import XCTest
@testable import Marketplace

final class MarketplaceViewModelTests: XCTestCase {

    func test_loadProducts_successfulFetch_triggersUpdate() async throws {
        
        let products = [Product(id: "1",
                                sku: "",
                                title: "",
                                productDescription: "",
                                listPrice: "",
                                isForSale: false,
                                isAgeRestricted: false,
                                images: ImagesUnion.imagesClass(ImagesClass(the750: The750(src: "",
                                                                                           url: "",
                                                                                           width: 750)))),
                        
                        Product(id: "2",
                                sku: "",
                                title: "",
                                productDescription: "",
                                listPrice: "",
                                isForSale: false,
                                isAgeRestricted: false,
                                images:ImagesUnion.imagesClass(ImagesClass(the750: The750(src: "",
                                                                                          url: "",
                                                                                          width: 750))))]
        let mockService = MockProductService()
        mockService.fetchedProducts = products
        //[Product(id: "1", title: "Test Product")]

        let viewModel = MarketplaceViewModel(service: mockService)
        let updateExpectation = XCTestExpectation(description: "onDataUpdate called")
        let loadingStartExpectation = XCTestExpectation(description: "Loading started")
        let loadingEndExpectation = XCTestExpectation(description: "Loading ended")

        viewModel.onDataUpdate = {
            updateExpectation.fulfill()
        }
        viewModel.onLoadingStateChange = { isLoading in
            if isLoading {
                loadingStartExpectation.fulfill()
            } else {
                loadingEndExpectation.fulfill()
            }
        }

        viewModel.loadProducts()

        await fulfillment(of: [loadingStartExpectation, updateExpectation, loadingEndExpectation], timeout: 1.0)
        XCTAssertEqual(viewModel.products.count, 2)
    }

    func test_loadProducts_withError_triggersOnError() async throws {
        let mockService = MockProductService()
        mockService.shouldThrow = true

        let viewModel = MarketplaceViewModel(service: mockService)
        let errorExpectation = XCTestExpectation(description: "onError called")
        let loadingStartExpectation = XCTestExpectation(description: "Loading started")
        let loadingEndExpectation = XCTestExpectation(description: "Loading ended")

        viewModel.onError = { error in
            XCTAssertEqual(error, "Mock fetch error")
            errorExpectation.fulfill()
        }
        viewModel.onLoadingStateChange = { isLoading in
            if isLoading {
                loadingStartExpectation.fulfill()
            } else {
                loadingEndExpectation.fulfill()
            }
        }

        viewModel.loadProducts()

        await fulfillment(of: [loadingStartExpectation, errorExpectation, loadingEndExpectation], timeout: 1.0)
        XCTAssertEqual(viewModel.products.count, 0)
    }
}
