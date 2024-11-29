import XCTest
@testable import Carry1stCommerce

final class LiveAPIServiceTests: XCTestCase {
	var apiService: LiveAPIService!
	var mockURLProtocol: MockURLProtocol!
	
	override func setUp() {
		super.setUp()
		mockURLProtocol = MockURLProtocol()
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		let mockSession = URLSession(configuration: configuration)
		
		apiService = LiveAPIService(urlSession: mockSession)
	}
	
	override func tearDown() {
		apiService = nil
		mockURLProtocol = nil
		super.tearDown()
	}
	
	func testGetProductBundles_SuccessfulResponse() async throws {
		
		let expectedProducts = [Product.lives10, Product.lives25]
		let jsonData = try JSONEncoder().encode(expectedProducts)
		
		MockURLProtocol.requestHandler = { request in
			guard let url = request.url,
				  url.absoluteString.contains("my-json-server.typicode.com/carry1stdeveloper/mock-product-api/productBundles") else {
				throw URLError(.badURL)
			}
			
			let response = HTTPURLResponse(
				url: url,
				statusCode: 200,
				httpVersion: nil,
				headerFields: ["Content-Type": "application/json"]
			)!
			
			return (response, jsonData)
		}
		
		let result = await apiService.getProductBundles()
		
		switch result {
		case .success(let products):
			XCTAssertEqual(products.count, expectedProducts.count)
			XCTAssertEqual(products[0].id, expectedProducts[0].id)
			XCTAssertEqual(products[1].id, expectedProducts[1].id)
		case .failure(let error):
			XCTFail("Expected success, got failure with error: \(error)")
		}
	}
	
	func testGetProductBundles_UnauthorizedResponse() async throws {
		
		MockURLProtocol.requestHandler = { request in
			guard let url = request.url,
				  url.absoluteString.contains("my-json-server.typicode.com/carry1stdeveloper/mock-product-api/productBundles") else {
				throw URLError(.badURL)
			}
			
			let response = HTTPURLResponse(
				url: url,
				statusCode: 401,
				httpVersion: nil,
				headerFields: nil
			)!
			
			return (response, Data())
		}
		
		let result = await apiService.getProductBundles()
		
		switch result {
		case .success:
			XCTFail("Expected unauthorized error")
		case .failure(let error):
			XCTAssertEqual(error, .unauthorized)
		}
	}
	
	func testGetProductBundles_InvalidData() async throws {
		
		MockURLProtocol.requestHandler = { request in
			guard let url = request.url,
				  url.absoluteString.contains("my-json-server.typicode.com/carry1stdeveloper/mock-product-api/productBundles") else {
				throw URLError(.badURL)
			}
			
			let response = HTTPURLResponse(
				url: url,
				statusCode: 200,
				httpVersion: nil,
				headerFields: ["Content-Type": "application/json"]
			)!
			
			let invalidJsonData = "Invalid JSON Data".data(using: .utf8)!
			return (response, invalidJsonData)
		}
		
		let result = await apiService.getProductBundles()
		
		switch result {
		case .success:
			XCTFail("Expected decoding error")
		case .failure(let error):
			XCTAssertEqual(error, .decode)
		}
	}
	
	func testGetProductBundles_NetworkError() async throws {
		
		MockURLProtocol.requestHandler = { _ in
			throw URLError(.timedOut)
		}
		
		let result = await apiService.getProductBundles()
		
		switch result {
		case .success:
			XCTFail("Expected unknown error")
		case .failure(let error):
			XCTAssertEqual(error, .unknown)
		}
	}
}

