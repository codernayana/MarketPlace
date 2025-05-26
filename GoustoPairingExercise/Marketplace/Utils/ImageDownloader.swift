//
//  ImageDownloader.swift
//  Marketplace
//
//  Created by Nayana NP on 24/05/2025.
//

import UIKit

protocol ImageDownloaderProtocol {
    func downloadImage(from url: URL) async -> UIImage?
    func clearCache()
}

class ImageDownloader {
    
    // MARK: - Variables
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession

    // MARK: Init methods
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - ImageDownloaderProtocol

extension ImageDownloader: ImageDownloaderProtocol {
    
    func downloadImage(from url: URL) async -> UIImage? {
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }

        do {
            let (data, _) = try await session.data(from: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: url as NSURL)
                return image
            }
        } catch {
            // handle default image return or error 
        }

        return nil
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
