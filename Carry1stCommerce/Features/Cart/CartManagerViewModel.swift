import Foundation

class CartManagerViewModel: ObservableObject {
	@Published var items: [CartItem] = []
	
	private func findCartItem(for product: Product) -> CartItem? {
		return items.first { $0.product.id == product.id }
	}
	
	func addToCart(_ product: Product) {
		if let index = items.firstIndex(where: { $0.product.id == product.id }) {
			items[index].quantity += 1
		} else {
			let newCartItem = CartItem(id: product.id, product: product, quantity: 1)
			items.append(newCartItem)
		}
	}
	
	func removeFromCart(_ cartItem: CartItem) {
		items.removeAll { $0.id == cartItem.id }
	}
	
	func updateQuantity(for cartItem: CartItem, quantity: Int) {
		if let index = items.firstIndex(where: { $0.id == cartItem.id }) {
			if quantity > 0 {
				items[index].quantity = quantity
			} else {
				items.remove(at: index)
			}
		}
	}
	
	func totalItems() -> Int {
		items.reduce(0) { $0 + $1.quantity }
	}
	
	func totalPrice() -> Double {
		items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
	}
	
	func itemCount(for product: Product) -> Int {
		findCartItem(for: product)?.quantity ?? 0
	}
}
