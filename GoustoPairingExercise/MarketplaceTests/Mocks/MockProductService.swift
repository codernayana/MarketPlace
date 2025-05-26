//
//  MockProductService.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

@testable import Marketplace
import UIKit

//protocol ProductServiceProtocol {
//    func fetchProducts(from url: URL) async throws -> [Product]
//}
//
//extension ProductService: ProductServiceProtocol {}

final class MockProductService: ProductServiceProtocol {
    
    var shouldThrow = false
    var fetchedProducts: [Product] = []

    func fetchProducts(from url: URL) async throws -> [Product] {
        if shouldThrow {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock fetch error"])
        }
        return fetchedProducts
    }
}
