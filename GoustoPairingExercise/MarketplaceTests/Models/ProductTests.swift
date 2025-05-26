import XCTest
@testable import Marketplace

// MARK: - Product Tests

class ProductTests: XCTestCase {

    func testSuccessfulDecode() throws {

        let decoder = JSONDecoder()

        let product = try decoder.decode(Product.self, from: XCTUnwrap(mockData))

        XCTAssertEqual(product.id, "00a0130e-bfea-11e7-a2c2-0617e74d8914")
        XCTAssertEqual(product.sku, "AP-FCD-BIS-06")
        XCTAssertEqual(product.title, "Love Shortie All Butter Shortbread")
        XCTAssertEqual(product.productDescription, "A rich all butter shortbread, delicately sweet and crumbly with a hint of sea salt, straight out of Scotland.")
        XCTAssertEqual(product.listPrice, "3.95")
        XCTAssertEqual(product.isForSale, true)
        XCTAssertEqual(product.isAgeRestricted, false)
    }
}

// MARK: - Test Helpers

extension ProductTests {

    var mockData: Data? {
        """
        {
         "id":"00a0130e-bfea-11e7-a2c2-0617e74d8914",
        "sku":"AP-FCD-BIS-06",
        "title":"Love Shortie All Butter Shortbread",
        "description":"A rich all butter shortbread, delicately sweet and crumbly with a hint of sea salt, straight out of Scotland.",
        "list_price":"3.95",
        "age_restricted":false,
        "is_for_sale":true,
        "images":{
        "750": {
        "src":"https://production-media.gousto.co.uk/cms/product-image-landscape/Shortbread-0663-x750.jpg",
        "url":"https://production-media.gousto.co.uk/cms/product-image-landscape/Shortbread-0663-x750.jpg",
        "width":750
        }}
        }
        """.data(using: .utf8)
    }
}
