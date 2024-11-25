import Foundation

protocol HTTPClient {
	var urlSession: URLSession { get }
	func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async -> Result<T, RequestError>
	init(urlSession: URLSession)
}

extension HTTPClient {
	func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async -> Result<T, RequestError> {
		var urlComponents = URLComponents()
		urlComponents.scheme = endpoint.scheme
		urlComponents.host = endpoint.host
		urlComponents.path = endpoint.path
		
		guard let url = urlComponents.url else { return .failure(.invalidURL) }
		
		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		request.allHTTPHeaderFields = endpoint.header
		
		if let body = endpoint.body {
			request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
		}
		
		do {
			let (data, response) = try await urlSession.data(for: request)
			guard let response = response as? HTTPURLResponse else {
				return .failure(.noResponse)
			}
			
			switch response.statusCode {
			case 200...299:
				guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
					return .failure(.decode)
				}
				return .success(decodedResponse)
			case 401:
				return .failure(.unauthorized)
			default:
				return .failure(.unexpectedStatusCode)
			}
		} catch {
			return .failure(.unknown)
		}
	}
}
