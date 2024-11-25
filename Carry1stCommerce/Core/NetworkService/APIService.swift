import Foundation

protocol APIServiceable {
	func getProductBundles() async -> Result<[Product], RequestError>
}

struct LiveAPIService: APIServiceable, HTTPClient {
	let urlSession: URLSession
	
	init(urlSession: URLSession = .shared) {
		self.urlSession = urlSession
	}
	
	func getProductBundles() async -> Result<[Product], RequestError> {
		await request(APIEndpoint.productBundles, responseType: [Product].self)
	}
}

#if DEBUG
// MARK: - Mock API Service
struct MockAPIService: APIServiceable {
	let product: [Product]
	
	init(product: [Product]) {
		self.product = product
	}
	
	func getProductBundles() async -> Result<[Product], RequestError> {
		return .success(product)
	}
}
#endif
