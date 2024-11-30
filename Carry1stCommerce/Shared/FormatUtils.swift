import Foundation

struct FormatUtils {
	static func formattedCurrency(value: Double, currencySymbol: String) -> String {
		return "\(currencySymbol)\(String(format: "%.2f", value))"
	}
	
}
