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
					loadingView
				} else if let error = productViewModel.error {
					errorView(error: error)
				} else {
					productGrid
				}
			}
			.task {
				await productViewModel.fetchProducts()
			}
			.navigationTitle(AppStrings.ProductList.navigationTitle)
			.navigationBarItems(trailing: cartButton)
		}
	}
	
	// MARK: - Views
	
	private var loadingView: some View {
		ProgressView(AppStrings.ProductList.loadingProducts)
			.padding()
			.foregroundColor(Color(uiColor: .label))
			.background(Color(uiColor: .secondarySystemBackground))
	}
	
	private func errorView(error: AlertData) -> some View {
		VStack(spacing: 16) {
			Text(error.message)
				.foregroundColor(.red)
				.padding()
				.background(Color(uiColor: .secondarySystemBackground))
			
			PrimaryButton(
				title: AppStrings.Common.retry,
				backgroundColor: .clear,
				textColor: .systemGray,
				action: {
					Task {
						await productViewModel.fetchProducts(forceRefresh: true)
					}
				}
			).foregroundStyle(.bar)
			
			
		}
	}
	
	private var productGrid: some View {
		ScrollView {
			LazyVGrid(columns: gridItems, spacing: 16) {
				ForEach(productViewModel.products) { product in
					ProductGridItem(product: product)
				}
			}
			.padding(.horizontal, 16)
		}
		.refreshable {
			await productViewModel.fetchProducts()
		}
	}
	
	private var cartButton: some View {
		NavigationLink(destination: CartView()) {
			CartBadgeView(itemCount: cartManager.totalItems())
				.toolbarRole(.editor)
		}
	}
}


#if DEBUG
struct ProductListView_Previews: PreviewProvider {
	static var previews: some View {
		let productViewModel = ProductViewModel(apiService: MockAPIService(product: [.lives10, .lives25, .lives500, .credits1250, .wrongImageURL]))
		ProductListView(productViewModel: productViewModel)
			.environmentObject(CartManagerViewModel(cartService: CartService()))
		
	}
}
#endif



