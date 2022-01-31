//
//  ProductRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 08.12.2021.
//

import XCTest
@testable import Shop

class ProductRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://secret-everglades-22465.herokuapp.com/")
    
    var productRequest: ProductRequestFactory!
    
    override func setUpWithError() throws {
        productRequest = RequestFactory().makeProductRequestFactory()
    }
    
    override func tearDownWithError() throws {
        productRequest = nil
    }
    
//    func testGetCatalog() {
//        
//        let expressionCatalogStub = CatalogResult(result: 1,products: [
//            Product(id: 123, name: "Ноутбук", price: 45600),
//            Product(productId: 456, productName: "Мышка", productPrice: 1000)
//        ])
//        
//        productRequest.getCatalog(numberPage: 1, categoryId: 1) { response in
//            switch response.result {
//            case .success(let catalog):
//                let firstProduct = catalog.products[0]
//                let secondProduct = catalog.products[1]
//                
//                XCTAssertEqual(firstProduct.productId, expressionCatalogStub.products[0].productId)
//                XCTAssertEqual(secondProduct.productId, expressionCatalogStub.products[1].productId)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
//    
//    func testGetProductById() {
//        
//        let expressionProductStub = ProductResult(result: 1,
//                                                  product: Product(productId: 123,
//                                                                   productName: "Ноутбук",
//                                                                   productPrice: 45600,
//                                                                   description: "Мощный игровой ноутбук"))
//        
//        productRequest.getProductById(productId: 123) { response in
//            switch response.result {
//            case .success(let productResul):
//                XCTAssertEqual(expressionProductStub.result, productResul.result)
//                XCTAssertEqual(expressionProductStub.product.productName, productResul.product.productName)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            
//            self.expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 10.0)
//    }
}
