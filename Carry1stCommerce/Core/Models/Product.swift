import Foundation

struct Product: Codable, Identifiable {
	let id: Int
	let name: String
	let description: String
	let price: Double
	let currencyCode: String
	let currencySymbol: String
	let quantity: Int
	let imageLocation: String
	let status: String
}
