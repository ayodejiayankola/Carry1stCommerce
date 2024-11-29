import Foundation

final class CartManagerViewModel: ObservableObject {
	@Published var items: [CartItem] = []
	private let cartService: CartServiceProtocol
	
	init(cartService: CartServiceProtocol) {
		self.cartService = cartService
		self.items = cartService.items
	}
	
	func addToCart(_ product: Product) {
		cartService.add(product: product)
		items = cartService.items
	}
	
	func removeFromCart(_ cartItem: CartItem) {
		cartService.remove(cartItem: cartItem)
		items = cartService.items
	}
	
	func updateQuantity(for cartItem: CartItem, quantity: Int) {
		cartService.update(cartItem: cartItem, quantity: quantity)
		items = cartService.items
	}
	
	func totalItems() -> Int {
		cartService.totalItems()
	}
	
	func totalPrice() -> Double {
		cartService.totalPrice()
	}
	
	func itemCount(for product: Product) -> Int {
		cartService.itemCount(for: product)
	}
}
