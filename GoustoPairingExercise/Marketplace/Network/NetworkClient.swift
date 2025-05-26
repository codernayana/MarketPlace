//
//  NetworkClient.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

import UIKit

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ url: URL) async throws -> T
}

class NetworkClient {
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
}

// MARK: - NetworkClientProtocol

extension NetworkClient: NetworkClientProtocol {
    
    func request<T: Decodable>(_ url: URL) async throws -> T {
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await session.data(from: url)
        } catch {
            throw NetworkError.unknown(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        default: throw NetworkError.statusCodeError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
