//
//  MarketplaceViewModel.swift
//  Marketplace
//
//  Created by Nayana NP on 24/05/2025.
//

import UIKit

class MarketplaceViewModel {
    
    private let service: ProductServiceProtocol
    private(set) var products: [Product] = []
    
    var onDataUpdate: (() -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    
    init(service: ProductServiceProtocol = ProductService()) {
         self.service = service
     }
    
    func loadProducts() {
        Task {
            await fetchProducts()
        }
    }
    
    @MainActor
    private func fetchProducts() async {
        onLoadingStateChange?(true)
        
        defer {
            onLoadingStateChange?(false)
        }
        
        guard let url = EndPoints.productsURL else {
            onError?("Invalid URL")
            return
        }
        
        do {
            products = try await service.fetchProducts(from: url)
            onDataUpdate?()
        } catch {
            onError?(error.localizedDescription)
        }
    }
}
