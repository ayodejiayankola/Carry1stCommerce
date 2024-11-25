import Foundation

protocol Endpoint {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var header: [String: String]? { get }
	var body: [String: Any]? { get }
}

extension Endpoint {
  var scheme: String {
		return "https"
	}
}
