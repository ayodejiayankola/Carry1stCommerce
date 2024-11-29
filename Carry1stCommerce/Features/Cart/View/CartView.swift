import SwiftUI

struct CartView: View {
	@EnvironmentObject private var cartManager: CartManagerViewModel
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					presentationMode.wrappedValue.dismiss()
				}) {
					Image(systemName: "chevron.left")
						.foregroundColor(.blue)
						.imageScale(.large)
				}
				
				Spacer()
				
				Text("Cart")
					.font(.headline)
				
				Spacer()
			}
			.padding(.leading, 10)
			
			if cartManager.items.isEmpty {
				emptyStateView
			} else {
				cartListView
			}
		}
		.navigationBarHidden(true)
		.navigationBarBackButtonHidden(true)
	}
	
	private var emptyStateView: some View {
		VStack(spacing: 20) {
			Image(systemName: "cart")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundColor(.gray)
			
			Text("Your cart is empty")
				.font(.title)
				.fontWeight(.semibold)
				.foregroundColor(.primary)
			
			Text("Looks like you haven't added anything to your cart yet. Start exploring and find something you like!")
				.font(.body)
				.multilineTextAlignment(.center)
				.foregroundColor(.secondary)
				.padding(.horizontal, 40)
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
						Text("$\(item.product.price, specifier: "%.2f")")
							.font(.subheadline)
							.foregroundColor(.gray)
					}
					
					Spacer()
					
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
							cartManager.updateQuantity(for: item, quantity: item.quantity + 1)
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
			}
			.onDelete { indexSet in
				indexSet.forEach { index in
					cartManager.removeFromCart(cartManager.items[index])
				}
			}
			
			Section {
				HStack {
					Text("Total")
						.font(.headline)
					Spacer()
					Text("$\(cartManager.totalPrice(), specifier: "%.2f")")
						.font(.headline)
						.foregroundColor(.blue)
				}
			}
		}
	}
}

#Preview {
	CartView()
		.environmentObject(CartManagerViewModel(cartService: CartService()))
}
