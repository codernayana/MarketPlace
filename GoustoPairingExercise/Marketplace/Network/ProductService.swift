//
//  ProductService.swift
//  Marketplace
//
//  Created by Nayana NP on 24/05/2025.
//

import UIKit

protocol ProductServiceProtocol {
    func fetchProducts(from url: URL) async throws -> [Product]
}

struct ProductService {
    
    var client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol = NetworkClient()) {
        self.client = client
    }
}

extension ProductService: ProductServiceProtocol {
    func fetchProducts(from url: URL) async throws -> [Product] {
        do {
            let response: ResponsePayload<[Product]> = try await client.request(url)
            return response.data
            
        } catch {
            throw error
        }
    }
}

