import Foundation

enum RequestError: Error {
	case invalidURL
	case noResponse
	case unauthorized
	case unexpectedStatusCode
	case decode
	case invalidData
	case unknown
}

extension RequestError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "The URL provided is invalid. Please check and try again."
		case .noResponse:
			return "No response received from the server. Please try again later."
		case .unauthorized:
			return "Unauthorized access. Please check your credentials."
		case .unexpectedStatusCode:
			return "Unexpected status code from the server."
		case .decode:
			return "Failed to decode the response. Please contact support."
		case .invalidData:
			return "The data received from the server is invalid."
		case .unknown:
			return "An unknown error occurred. Please try again."
		}
	}
}
