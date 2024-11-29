import Foundation

protocol CartServiceProtocol {
	var items: [CartItem] { get }
	func add(product: Product)
	func remove(cartItem: CartItem)
	func update(cartItem: CartItem, quantity: Int)
	func totalItems() -> Int
	func totalPrice() -> Double
	func itemCount(for product: Product) -> Int
}

final class CartService: CartServiceProtocol {
	private(set) var items: [CartItem] = []
	
	func add(product: Product) {
		if let index = items.firstIndex(where: { $0.product.id == product.id }) {
			let currentQuantity = items[index].quantity
			if currentQuantity < product.quantity {
				items[index].quantity += 1
			}
		} else {
			let newCartItem = CartItem(product: product, quantity: 1)
			items.append(newCartItem)
		}
	}
	
	
	func remove(cartItem: CartItem) {
		items.removeAll { $0.id == cartItem.id }
	}
	
	func update(cartItem: CartItem, quantity: Int) {
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
		items.first { $0.product.id == product.id }?.quantity ?? 0
	}
}
