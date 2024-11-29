import SwiftUI

struct CartView: View {
	@ObservedObject var cartManager: CartManagerViewModel
	@State private var isNavigatingToProductList = false
	
	var body: some View {
		  NavigationView {
			  if cartManager.items.isEmpty {
				  emptyStateView
					  .navigationTitle("")
			  } else {
				  cartListView
					  .navigationTitle("Cart")
			  }
		  }
		  .padding(.top, 0)
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
			
			Text("Looks like you haven’t added anything to your cart yet. Start exploring and find something you like!")
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
					
					HStack(spacing: 20) {
						Button(action: {
							print("Yes")
							cartManager.updateQuantity(for: item, quantity: item.quantity - 1)
						}) {
							Image(systemName: "minus.circle")
						}.buttonStyle(.plain)
						
						Text("\(item.quantity)")
							.font(.headline)
						
						Button(action: {
							print("No ...")
							cartManager.updateQuantity(for: item, quantity: item.quantity + 1)
						}) {
							Image(systemName: "plus.circle")
						}.buttonStyle(.plain)
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
	CartView(cartManager: CartManagerViewModel())
}
