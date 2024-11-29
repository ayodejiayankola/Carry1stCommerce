import XCTest
@testable import Carry1stCommerce

final class CartManagerViewModelTests: XCTestCase {
	var viewModel: CartManagerViewModel!
	var mockCartService: MockCartService!
	
	override func setUp() {
		super.setUp()
		mockCartService = MockCartService()
		viewModel = CartManagerViewModel(cartService: mockCartService)
	}
	
	override func tearDown() {
		viewModel = nil
		mockCartService = nil
		super.tearDown()
	}
	
	func testInitialization() {
		XCTAssertTrue(viewModel.items.isEmpty, "Items should be initially empty")
	}
	
	func testAddToCart() {
		let product = Product.lives10
		viewModel.addToCart(product)
		
		XCTAssertEqual(viewModel.items.count, 1, "Should have one item after adding a product")
		XCTAssertEqual(viewModel.items.first?.product.id, product.id, "Added product should match")
		XCTAssertEqual(viewModel.items.first?.quantity, 1, "Quantity should be 1 for a new product")
	}
	
	func testRemoveFromCart() {
		let product = Product.lives10
		viewModel.addToCart(product)
		
		let cartItem = viewModel.items.first!
		viewModel.removeFromCart(cartItem)
		
		XCTAssertTrue(viewModel.items.isEmpty, "Cart should be empty after removing the only item")
	}
	
	func testUpdateQuantity() {
		let product = Product.lives10
		viewModel.addToCart(product)
		
		let cartItem = viewModel.items.first!
		viewModel.updateQuantity(for: cartItem, quantity: 3)
		
		XCTAssertEqual(viewModel.items.first?.quantity, 3, "Quantity should be updated")
	}
	
	func testTotalItems() {
		let product1 = Product.lives10
		let product2 = Product.lives25
		
		viewModel.addToCart(product1)
		viewModel.addToCart(product1)
		viewModel.addToCart(product2)
		
		XCTAssertEqual(viewModel.totalItems(), 3, "Total items should be correct")
	}
	
	func testTotalPrice() {
		let product1 = Product.lives10
		let product2 = Product.lives25
		
		viewModel.addToCart(product1)
		viewModel.addToCart(product1)
		viewModel.addToCart(product2)
		
		let expectedTotalPrice = (product1.price * 2) + product2.price
		XCTAssertEqual(viewModel.totalPrice(), expectedTotalPrice, "Total price should be calculated correctly")
	}
	
	func testItemCount() {
		let product = Product.lives10
		
		viewModel.addToCart(product)
		viewModel.addToCart(product)
		
		XCTAssertEqual(viewModel.itemCount(for: product), 2, "Item count should reflect multiple additions")
	}
}
