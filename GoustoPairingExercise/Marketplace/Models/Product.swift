// MARK: - Product

import Foundation

/// ``Product`` represents the details of a product which can be sold on the Gousto marketplace.

struct Product: Identifiable, Decodable {
    typealias ID = String

    let id: ID
    let sku: String
    let title: String
    let productDescription: String
    let listPrice: String
    let isForSale: Bool
    let isAgeRestricted: Bool
    let images: ImagesUnion
    
    private enum CodingKeys: String, CodingKey {
        case id
        case sku
        case title
        case productDescription = "description"
        case listPrice = "list_price"
        case isForSale = "is_for_sale"
        case isAgeRestricted = "age_restricted"
        case images
    }
}

struct ImagesClass: Decodable {
    let the750: The750
    
    enum CodingKeys: String, CodingKey {
    case the750 = "750"
}
    
}

// MARK: - The750
struct The750: Decodable {
    let src, url: String
    let width: Int
}

enum ImagesUnion: Decodable {
    case imagesClass(ImagesClass)
    case emptyArray

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let imagesClass = try? container.decode(ImagesClass.self) {
            self = .imagesClass(imagesClass)
            return
        }

        // Try to decode as an empty array
        if let emptyArray = try? container.decode([AnyCodable].self), emptyArray.isEmpty {
            self = .emptyArray
            return
        }

        throw DecodingError.typeMismatch(
            ImagesUnion.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Cannot decode ImagesUnion"
            )
        )
    }
}

struct AnyCodable: Decodable {}

extension Product {
    var imageURL: URL? {
        switch images {
        case .imagesClass(let img):
            return URL(string: img.the750.src)
        case .emptyArray:
            return nil
        }
    }
}
