import SwiftUI

struct CartView: View {
	@EnvironmentObject private var cartManager: CartManagerViewModel
	@Environment(\.presentationMode) var presentationMode
	@State private var showQuantityLimitAlert = false
	@State private var quantityLimitMessage = ""

	var body: some View {
		VStack {
			headerView
			
			if cartManager.items.isEmpty {
				emptyStateView
			} else {
				cartListView
			}
		}
		.navigationBarHidden(true)
		.navigationBarBackButtonHidden(true)
	}
	
	private var headerView: some View {
		HStack {
			Button(action: {
				presentationMode.wrappedValue.dismiss()
			}) {
				Image(systemName: "chevron.left")
					.foregroundColor(.blue)
					.imageScale(.large)
			}
			
			Spacer()
			
			Text(AppStrings.CartView.cartTitle)
				.font(.headline)
			
			Spacer()
		}
		.padding(.leading, 10)
	}

//	private var emptyStateView: some View {
//		VStack(spacing: 20) {
//			Image(systemName: "cart")
//				.resizable()
//				.scaledToFit()
//				.frame(width: 100, height: 100)
//				.foregroundColor(.gray)
//			
//			Text(AppStrings.CartView.emptyCartMessage)
//				.font(.title)
//				.fontWeight(.semibold)
//				.foregroundColor(.primary)
//			
//			Text(AppStrings.CartView.emptyCartDescription)
//				.font(.body)
//				.multilineTextAlignment(.center)
//				.foregroundColor(.secondary)
//				.padding(.horizontal, 40)
//		}
//		.frame(maxWidth: .infinity, maxHeight: .infinity)
//		.background(Color(.systemGroupedBackground))
//		.edgesIgnoringSafeArea(.all)
	private var emptyStateView: some View {
		VStack(spacing: 20) {
			Image(systemName: "cart")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundColor(.gray)
				.accessibilityHidden(true)

			Text(AppStrings.CartView.emptyCartMessage)
				.font(.title)
				.fontWeight(.semibold)
				.foregroundColor(.primary)

			Text(AppStrings.CartView.emptyCartDescription)
				.font(.body)
				.multilineTextAlignment(.center)
				.foregroundColor(.secondary)
				.padding(.horizontal, 40)
			
			Button(action: {
				presentationMode.wrappedValue.dismiss()
			}) {
				Text("Continue Shopping")
					.padding()
					.background(Color.blue)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
			.padding(.top)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color(.systemGroupedBackground))
		.edgesIgnoringSafeArea(.all)
	
	}

	private var cartListView: some View {
		List {
			ForEach(cartManager.items) { item in
				HStack {
					VStack(alignment: .leading) {
						Text(item.product.name)
							.font(.headline)
						Text(FormatUtils.formattedCurrency(value: item.product.price, currencySymbol: "$"))
							.font(.subheadline)
							.foregroundColor(.gray)
					}
					
					Spacer()
					
					quantityControlView(for: item)
				}
			}
			.onDelete { indexSet in
				indexSet.forEach { index in
					cartManager.removeFromCart(cartManager.items[index])
				}
			}
			
			totalPriceSection
		}
		.overlay(
			Group {
				if showQuantityLimitAlert {
					QuantityLimitAlertView(message: quantityLimitMessage)
				}
			}
		)
	}
	
	private func quantityControlView(for item: CartItem) -> some View {
		HStack(spacing: 10) {
			Button(action: {
				cartManager.updateQuantity(for: item, quantity: item.quantity - 1)
			}) {
				Image(systemName: "minus.circle")
			}
			.buttonStyle(.plain)
			
			Text("\(item.quantity)")
				.font(.headline)
			
			Button(action: {
				let currentCount = item.quantity
				if handleQuantityLimit(
					isShown: $showQuantityLimitAlert,
					message: $quantityLimitMessage,
					item: item,
					maxQuantity: item.product.quantity,
					currentQuantity: currentCount
				) {
					cartManager.updateQuantity(for: item, quantity: item.quantity + 1)
				}
			}) {
				Image(systemName: "plus.circle")
			}
			.buttonStyle(.plain)
			
			Button(action: {
				cartManager.removeFromCart(item)
			}) {
				Image(systemName: "trash")
					.foregroundColor(.red)
			}
			.buttonStyle(.plain)
		}
	}
	
	private var totalPriceSection: some View {
		Section {
			HStack {
				Text(AppStrings.CartView.totalLabel)
					.font(.headline)
				Spacer()
				Text(FormatUtils.formattedCurrency(value: cartManager.totalPrice(), currencySymbol: "$"))
					.font(.headline)
					.foregroundColor(.blue)
			}
		}
	}
}

#if DEBUG
#Preview {
	CartView()
		.environmentObject(CartManagerViewModel(cartService: CartService()))
}
#endif
