import SwiftUI

struct ProductGridItem: View {
	var product: Product
	@EnvironmentObject private var cartManager: CartManagerViewModel
	
	var body: some View {
		NavigationLink(destination: ProductDetailView(product: product)) {
			VStack(alignment: .center) {
				if let imageURL = URL(string: product.imageLocation) {
					URLImage(url: imageURL, size: CGSize(width: UIScreen.main.bounds.width / 2 - 32, height: 100))
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
					
					Text("$\(product.price, specifier: "%.2f")")
						.font(.subheadline)
						.foregroundColor(Color(uiColor: .secondaryLabel))
					
					if cartManager.itemCount(for: product) > 0 {
						Text("In Cart: \(cartManager.itemCount(for: product))")
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
struct ProductGridItem_Previews: PreviewProvider {
	static var previews: some View {
		let mockCartService = CartService()
		let mockCartManager = CartManagerViewModel(cartService: mockCartService)
		
		return ProductGridItem(product: .lives125)
			.environmentObject(mockCartManager)
	}
}
#endif
