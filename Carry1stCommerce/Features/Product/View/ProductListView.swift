import SwiftUI

struct ProductListView: View {
	@StateObject private var productViewModel: ProductViewModel
	@EnvironmentObject private var cartManager: CartManagerViewModel
	
	private let gridItems = [
		GridItem(.flexible(), spacing: 16),
		GridItem(.flexible(), spacing: 16)
	]
	
	init(productViewModel: ProductViewModel) {
		_productViewModel = StateObject(wrappedValue: productViewModel)
	}
	
	var body: some View {
		NavigationView {
			Group {
				if productViewModel.isLoading {
					ProgressView("Loading products...")
						.padding()
						.foregroundColor(Color(uiColor: .label))
						.background(Color(uiColor: .secondarySystemBackground))
				} else if let error = productViewModel.error {
					Text(error.message)
						.foregroundColor(.red)
						.padding()
						.background(Color(uiColor: .secondarySystemBackground))
				} else {
					ScrollView {
						LazyVGrid(columns: gridItems, spacing: 16) {
							ForEach(productViewModel.products) { product in
								ProductGridItem(product: product)
									.padding(.horizontal, 16)
							}
						}
						.padding(.horizontal, 16)
					}
				}
			}
			.task {
				await productViewModel.fetchProducts()
			}
			.navigationTitle("Carry1st Commerce")
			.navigationBarItems(trailing:
									NavigationLink(destination: CartView()) {
				CartBadgeView(itemCount: cartManager.totalItems())
					.toolbarRole(.editor)
			}
			)
		}
	}
}

#if DEBUG
struct ProductListView_Previews: PreviewProvider {
	static var previews: some View {
		let productViewModel = ProductViewModel(apiService: MockAPIService(product: [.lives10, .lives25, .lives500, .credits1250, .noImage]))
		ProductListView(productViewModel: productViewModel)
			.environmentObject(CartManagerViewModel(cartService: CartService()))
		
	}
}
#endif
