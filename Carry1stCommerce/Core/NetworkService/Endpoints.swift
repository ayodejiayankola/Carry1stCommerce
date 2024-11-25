import Foundation

enum APIEndpoint {
	case productBundles
}

extension APIEndpoint: Endpoint {
	var host: String {
		return "my-json-server.typicode.com"
	}
	
	var path: String {
		switch self {
		case .productBundles:
			return "/carry1stdeveloper/mock-product-api/productBundles"
		}
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var header: [String: String]? {
		return ["Accept": "application/json"]
	}
	
	var body: [String: Any]? {
		return nil
	}
	
	var queryParameters: [URLQueryItem]? {
		return nil
	}
}
