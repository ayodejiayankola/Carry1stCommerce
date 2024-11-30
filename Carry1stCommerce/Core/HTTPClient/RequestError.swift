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
			  return AppStrings.Error.invalidURL
		  case .noResponse:
			  return AppStrings.Error.noResponse
		  case .unauthorized:
			  return AppStrings.Error.unauthorized
		  case .unexpectedStatusCode:
			  return AppStrings.Error.unexpectedStatusCode
		  case .decode:
			  return AppStrings.Error.decode
		  case .invalidData:
			  return AppStrings.Error.invalidData
		  case .unknown:
			  return AppStrings.Error.unknownError
		}
	}
}
