import SwiftUI

struct QuantityLimitAlertView: View {
	let message: String
	
	static let defaultMessages = [
		AppStrings.QuantityLimitAlert.maximumStockLimitReached,
		   AppStrings.QuantityLimitAlert.noMoreItemsAvailable,
		   AppStrings.QuantityLimitAlert.maximumQuantityExceeded,
		   AppStrings.QuantityLimitAlert.stockLimitHit,
		   AppStrings.QuantityLimitAlert.cantAddMoreProduct,
		   AppStrings.QuantityLimitAlert.maximumAvailableQuantity
	]
	
	static func randomMessage() -> String {
		defaultMessages.randomElement() ?? AppStrings.QuantityLimitAlert.maximumAvailableQuantity
	}
	
	var body: some View {
		Text(message)
			.foregroundColor(.red)
			.padding()
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
		
		if let product = (item as? Product)?.name ?? (item as? CartItem)?.product.name {

			message.wrappedValue = String(format: AppStrings.QuantityLimitAlert.maximumQuantityForProduct, product)
		} else {
			message.wrappedValue =    AppStrings.QuantityLimitAlert.maximumQuantityReached
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
