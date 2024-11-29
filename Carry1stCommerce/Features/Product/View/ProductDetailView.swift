import SwiftUI
import SwiftUI

struct ProductDetailView: View {
	var product: Product
	@EnvironmentObject private var cartManager: CartManagerViewModel
	@State private var showQuantityLimitAlert = false
	
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				
				if let imageURL = URL(string: product.imageLocation) {
					URLImage(url: imageURL, size: CGSize(width: UIScreen.main.bounds.width - 32, height: 300))
						.aspectRatio(contentMode: .fill)
						.frame(height: 300)
						.clipped()
						.background(Color(uiColor: .secondarySystemBackground))
						.cornerRadius(12)
						.overlay(
							RoundedRectangle(cornerRadius: 12)
								.stroke(Color.gray.opacity(0.1), lineWidth: 1)
						)
						.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
				}
				
				VStack(alignment: .leading, spacing: 12) {
					
					Text(product.name)
						.font(.title)
						.fontWeight(.semibold)
						.foregroundColor(Color(uiColor: .label))
						.lineLimit(2)
						.truncationMode(.tail)
					
					Text("$\(product.price, specifier: "%.2f")")
						.font(.title2)
						.fontWeight(.medium)
						.foregroundColor(Color(uiColor: .tintColor))
					
					Text(product.description)
						.font(.body)
						.foregroundColor(Color(uiColor: .secondaryLabel))
						.lineLimit(3)
						.truncationMode(.tail)
						.padding(.top, 8)
					
					HStack(spacing: 20) {
						Button(action: {
							if cartManager.itemCount(for: product) < product.quantity {
								cartManager.addToCart(product)
							} else {
								withAnimation {
									showQuantityLimitAlert = true
									DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
										showQuantityLimitAlert = false
									}
								}
							}
						}) {
							Text("Add to Cart")
								.font(.headline)
								.foregroundColor(.white)
								.frame(maxWidth: .infinity)
								.padding()
								.background(Color(uiColor: .systemBlue))
								.cornerRadius(10)
								.shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
						}
						
						Button(action: {}) {
							Text("Buy Now")
								.font(.headline)
								.foregroundColor(.white)
								.frame(maxWidth: .infinity)
								.padding()
								.background(Color(uiColor: .secondaryLabel))
								.cornerRadius(10)
								.shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
						}
					}
					.padding(.top, 20)
					
					Text("In Cart: \(cartManager.itemCount(for: product))")
						.font(.subheadline)
						.foregroundColor(Color(uiColor: .label))
						.padding(.top, 8)
						.frame(maxWidth: .infinity, alignment: .center)
				}
				.padding([.horizontal, .top])
				
				if showQuantityLimitAlert {
					Text("Maximum quantity reached")
						.foregroundColor(.white)
						.padding()
						.background(Color.red)
						.cornerRadius(8)
						.transition(.opacity)
						.animation(.easeInOut, value: showQuantityLimitAlert)
				}
			}
		}
		.navigationBarItems(trailing:
								NavigationLink(destination: CartView()) {
			CartBadgeView(itemCount: cartManager.totalItems())
				.toolbarRole(.editor)
		}
		)
		.navigationBarTitleDisplayMode(.inline)
		.background(Color(uiColor: .systemBackground))
	}
}

#if DEBUG
#Preview {
	ProductDetailView(product: .lives10)
		.environmentObject(CartManagerViewModel(cartService: CartService()))
}
#endif
