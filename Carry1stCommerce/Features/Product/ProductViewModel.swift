import Foundation

@MainActor
final class ProductViewModel: ObservableObject {
	
	@Published private(set) var products: [Product] = []
	@Published var error: AlertData?
	@Published private(set) var isLoading: Bool = false
	
	private let apiService: APIServiceable
	
	init(apiService: APIServiceable) {
		self.apiService = apiService
	}
	
	func fetchProducts(forceRefresh: Bool = false) async {
		guard forceRefresh || products.isEmpty else { return }
		isLoading = true
		error = nil
		
		let result = await apiService.getProductBundles()
		handleResult(result)
		
		isLoading = false
	}
	
	private func handleResult(_ result: Result<[Product], RequestError>) {
		switch result {
		case .success(let products):
			self.products = products
		case .failure(let error):
			self.error = AlertData(message: error.errorDescription ?? AppStrings.ProductViewModel.fetchProductsErrorMessage)
		}
	}
}
