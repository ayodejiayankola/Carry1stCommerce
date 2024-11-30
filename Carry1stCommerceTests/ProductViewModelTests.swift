import XCTest
@testable import Carry1stCommerce

@MainActor
final class ProductViewModelTests: XCTestCase {
	
	var viewModel: ProductViewModel!
	
	override func setUp() {
		viewModel = ProductViewModel(
			apiService: MockAPIService(product: [.credits1250, .credits150])
		)
	}
	
	override func tearDown() {
		viewModel = nil
		super.tearDown()
	}
	
	func testInitialState() {
		XCTAssertTrue(viewModel.products.isEmpty)
		XCTAssertFalse(viewModel.isLoading)
		XCTAssertNil(viewModel.error)
	}
	
	
	func testFetchProductsSuccess() async {
		
		await viewModel.fetchProducts()
		
		XCTAssertEqual(viewModel.products.count, 2)
		XCTAssertFalse(viewModel.isLoading)
		XCTAssertNil(viewModel.error)
	}
	
	func testFetchProductsOnlyOnce() async {
		
		await viewModel.fetchProducts()
		let initialProductCount = viewModel.products.count
		await viewModel.fetchProducts()
		
		XCTAssertEqual(viewModel.products.count, initialProductCount)
	}
	
	func testForceRefreshFetch() async {
		viewModel = ProductViewModel(
			apiService: MockAPIService(product: [.credits1250])
		)
		
		await viewModel.fetchProducts()
		XCTAssertEqual(viewModel.products.count, 1)
		
		viewModel = ProductViewModel(
			apiService: MockAPIService(product: [.credits150])
		)
		await viewModel.fetchProducts(forceRefresh: true)
		
		XCTAssertEqual(viewModel.products.count, 1)
	}
}
