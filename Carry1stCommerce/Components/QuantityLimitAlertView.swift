import SwiftUI

struct QuantityLimitAlertView: View {
	let message: String
	
	static let defaultMessages = [
		"Oops! Maximum stock limit reached",
		"Sorry, no more items available",
		"Maximum quantity exceeded",
		"Stock limit hit for this item",
		"Can't add more of this product",
		"Reached maximum available quantity"
	]
	
	static func randomMessage() -> String {
		defaultMessages.randomElement() ?? "Maximum quantity reached"
	}
	
	var body: some View {
		Text(message)
			.foregroundColor(.white)
			.padding()
			.background(Color.red)
			.cornerRadius(8)
			.transition(.opacity)
			.animation(.easeInOut, value: true)
	}
}

extension View {
	func handleQuantityLimit(
		isShown: Binding<Bool>,
		message: Binding<String>,
		item: Any,
		maxQuantity: Int,
		currentQuantity: Int
	) -> Bool {
		guard currentQuantity >= maxQuantity else { return true }
		
		if let product = item as? Product {
			message.wrappedValue = "Maximum quantity reached for \(product.name)"
		} else if let cartItem = item as? CartItem {
			message.wrappedValue = "Maximum quantity reached for \(cartItem.product.name)"
		} else {
			message.wrappedValue = "Maximum quantity reached"
		}
		
		withAnimation {
			isShown.wrappedValue = true
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			isShown.wrappedValue = false
		}
		
		return false
	}
}

#Preview {
	QuantityLimitAlertView(message: QuantityLimitAlertView.randomMessage())
}
