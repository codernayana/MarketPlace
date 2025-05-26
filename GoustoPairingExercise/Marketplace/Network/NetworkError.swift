//
//  NetworkError.swift
//  Marketplace
//
//  Created by Nayana NP on 26/05/2025.
//

enum NetworkError: Error {
    case unknown(Error)
    case invalidResponse
    case statusCodeError(Int)
    case decodingFailed(Error)
}
