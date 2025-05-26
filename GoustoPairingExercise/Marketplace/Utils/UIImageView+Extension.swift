//
//  UIImageView+Extension.swift
//  Marketplace
//
//  Created by Nayana NP on 24/05/2025.
//

import UIKit

extension UIImageView {
    
    private static var sharedDownloader = ImageDownloader()
    
    func setImage(from url: URL,
                  placeholder: UIImage? = nil,
                  downloader: ImageDownloaderProtocol = UIImageView.sharedDownloader) {
        Task {
            await MainActor.run {
                self.image = placeholder
            }
            
            let image = await downloader.downloadImage(from: url)
            
            await MainActor.run {
                self.image = image
            }
        }
    }
    
    static func make(image: UIImage? = nil,
                     accessibilityIdentifier: String? = nil,
                     contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let image = image {
            imageView.image = image
        }
        imageView.accessibilityIdentifier = accessibilityIdentifier
        imageView.contentMode = contentMode
        return imageView
    }
}
