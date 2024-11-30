import XCTest
@testable import Carry1stCommerce

class CartServiceTests: XCTestCase {
	var cartService: CartService!
	
	override func setUp() {
		super.setUp()
		cartService = CartService()
	}
	
	override func tearDown() {
		cartService = nil
		super.tearDown()
	}
	
	func testInitialState() {
		XCTAssertTrue(cartService.items.isEmpty)
	}
	
	func testAddNewProduct() {
		let product = Product.lives10
		cartService.add(product: product)
		
		XCTAssertEqual(cartService.items.count, 1)
		XCTAssertEqual(cartService.items.first?.quantity, 1)
	}
	
	func testAddExistingProduct() {
		let product = Product.credits1250
		cartService.add(product: product)
		cartService.add(product: product)
		
		XCTAssertEqual(cartService.items.count, 1)
		XCTAssertEqual(cartService.items.first?.quantity, 2)
	}
	
	func testRemoveProduct() {
		let product = Product.credits150
		cartService.add(product: product)
		
		let cartItem = cartService.items.first!
		cartService.remove(cartItem: cartItem)
		
		XCTAssertTrue(cartService.items.isEmpty)
	}
	
	func testAddProductBeyondStock() {
		let product = Product.lives10
		cartService.add(product: product)
		cartService.add(product: product)
		cartService.add(product: product)
		
		XCTAssertEqual(cartService.items.first?.quantity, 2)
		XCTAssertEqual(cartService.items.count, 1)
	}
	
	
	func testUpdateQuantity() {
		let product = Product.credits5000
		cartService.add(product: product)
		
		let cartItem = cartService.items.first!
		cartService.update(cartItem: cartItem, quantity: 3)
		
		XCTAssertEqual(cartService.items.first?.quantity, 3)
	}
	
	func testUpdateQuantityToZero() {
		let product = Product.credits1250
		cartService.add(product: product)
		
		let cartItem = cartService.items.first!
		cartService.update(cartItem: cartItem, quantity: 0)
		
		XCTAssertTrue(cartService.items.isEmpty)
	}
	
	func testTotalItems() {
		let product1 = Product.lives25
		let product2 = Product.credits1250
		
		cartService.add(product: product1)
		cartService.add(product: product1)
		cartService.add(product: product2)
		
		XCTAssertEqual(cartService.totalItems(), 3)
	}
	
	
	func testTotalPrice() {
		let product1 = Product.credits1250
		let product2 = Product.credits1250
		
		cartService.add(product: product1)
		cartService.add(product: product1)
		cartService.add(product: product2)
		
		XCTAssertEqual(cartService.totalPrice(), 15.0)
	}
	
	func testItemCount() {
		let product = Product.credits1250
		cartService.add(product: product)
		cartService.add(product: product)
		
		XCTAssertEqual(cartService.itemCount(for: product), 2)
	}
	
	func testRemoveNonExistingProduct() {
		let nonExistentCartItem = CartItem(product: Product.lives10, quantity: 1)
		cartService.remove(cartItem: nonExistentCartItem)
		
		XCTAssertTrue(cartService.items.isEmpty)
	}
}
