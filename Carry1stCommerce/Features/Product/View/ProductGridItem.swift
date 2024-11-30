import SwiftUI

struct ProductGridItem: View {
	var product: Product
	@EnvironmentObject private var cartManager: CartManagerViewModel
	
	private static var imageWidth: CGFloat {
		LayoutUtils.gridImageWidth(for: 2)
	}
	
	private var formattedPrice: String {
		FormatUtils.formattedCurrency(value: product.price, currencySymbol: product.currencySymbol)
	}
	
	var body: some View {
		NavigationLink(destination: ProductDetailView(product: product)) {
			VStack(alignment: .center) {
				if let imageURL = URL(string: product.imageLocation) {
					URLImage(url: imageURL, size: CGSize(width: Self.imageWidth, height: 100))
						.aspectRatio(contentMode: .fill)
						.frame(maxWidth: .infinity)
						.frame(height: 100)
						.clipped()
						.background(Color(uiColor: .secondarySystemBackground))
				}
				
				VStack(alignment: .center, spacing: 8) {
					Text(product.name)
						.font(.title3)
						.fontWeight(.semibold)
						.foregroundColor(Color(uiColor: .label))
					
					Text(formattedPrice)
						.font(.subheadline)
						.foregroundColor(Color(uiColor: .secondaryLabel))
					
					let itemCount = cartManager.itemCount(for: product)
					if itemCount > 0 {
						Text("\(AppStrings.ProductDetail.inCart) \(itemCount)")
							.font(.caption)
							.foregroundColor(Color(uiColor: .systemBlue))
					}
				}
				.padding(.horizontal, 8)
				.padding(.vertical, 6)
			}
			.background(Color(uiColor: .systemBackground))
			.cornerRadius(10)
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.gray.opacity(0.2), lineWidth: 1)
			)
			.shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
		}
	}
}

#if DEBUG
#Preview {
		let mockCartService = CartService()
		let mockCartManager = CartManagerViewModel(cartService: mockCartService)
		let mockProduct = Product.credits250
		return ProductGridItem(product: mockProduct)
			.environmentObject(mockCartManager)
	}
#endif
