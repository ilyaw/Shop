//
//  ProductRequestTests.swift
//  ShopTests
//
//  Created by Ilya on 08.12.2021.
//

import XCTest
@testable import Shop

class ProductRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    var productRequest: ProductRequestFactory!
    
    override func setUpWithError() throws {
        productRequest = RequestFactory().makeProductRequestFactory()
    }
    
    override func tearDownWithError() throws {
        productRequest = nil
    }
    
    func testGetCatalog() {
        
        let expressionCatalogsStub = [
            CatalogResult.Product(productId: 123, productName: "Ноутбук", price: 45600),
            CatalogResult.Product(productId: 456, productName: "Мышка", price: 1000)
        ]
        
        productRequest.getCatalog(numberPage: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let catalogs):
                let firstProduct = catalogs[0]
                let secondProduct = catalogs[1]
                
                XCTAssertEqual(firstProduct.productId, expressionCatalogsStub[0].productId)
                XCTAssertEqual(secondProduct.productId, expressionCatalogsStub[1].productId)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetProductById() {
        
        let expressionProductStub = ProductResult(result: 1,
                                                  productName: "Ноутбук",
                                                  productPrice: 45600,
                                                  productDescription: "Мощный игровой ноутбук")
        
        productRequest.getProductById(productId: 123) { response in
            switch response.result {
            case .success(let product):
                XCTAssertEqual(expressionProductStub.result, product.result)
                XCTAssertEqual(expressionProductStub.productName, product.productName)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            self.expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
