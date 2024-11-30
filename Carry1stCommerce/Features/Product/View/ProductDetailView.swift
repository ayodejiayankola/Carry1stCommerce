import SwiftUI

struct ProductDetailView: View {
	var product: Product
	@EnvironmentObject private var cartManager: CartManagerViewModel
	@State private var showQuantityLimitAlert = false
	@State private var quantityLimitMessage = ""
	
	private var imageHeight: CGFloat { 300 }
	private var horizontalPadding: CGFloat { 32 }
	
	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				productImageView
				
				productDetailsView
				
				if showQuantityLimitAlert {
					QuantityLimitAlertView(message: quantityLimitMessage)
				}
			}
		}
		.navigationBarItems(trailing: cartBadgeView)
		.toolbarRole(.editor)
		.navigationBarTitleDisplayMode(.inline)
		.background(Color(uiColor: .systemBackground))
	}
}

private extension ProductDetailView {
	
	var productImageView: some View {
		Group {
			if let imageURL = URL(string: product.imageLocation) {
				URLImage(
					url: imageURL,
					size: CGSize(width: LayoutUtils.screenWidth - horizontalPadding, height: imageHeight)
				)
				.aspectRatio(contentMode: .fill)
				.frame(height: imageHeight)
				.clipped()
				.background(Color(uiColor: .secondarySystemBackground))
				.cornerRadius(12)
				.overlay(
					RoundedRectangle(cornerRadius: 12)
						.stroke(Color.gray.opacity(0.1), lineWidth: 1)
				)
				.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
			}
		}
	}
	
	var productDetailsView: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text(product.name)
				.font(.title)
				.fontWeight(.semibold)
				.foregroundColor(Color(uiColor: .label))
				.lineLimit(2)
				.truncationMode(.tail)
			
			Text(FormatUtils.formattedCurrency(value: product.price, currencySymbol: product.currencySymbol))
				.font(.title2)
				.fontWeight(.medium)
				.foregroundColor(Color(uiColor: .tintColor))
			
			Text(product.description)
				.font(.body)
				.foregroundColor(Color(uiColor: .secondaryLabel))
				.lineLimit(3)
				.truncationMode(.tail)
				.padding(.top, 8)
			
			actionButtons
			
			Text("\(AppStrings.ProductDetail.inCart) \(cartManager.itemCount(for: product))")
				.font(.subheadline)
				.foregroundColor(Color(uiColor: .label))
				.padding(.top, 8)
				.frame(maxWidth: .infinity, alignment: .center)
		}
		.padding([.horizontal, .top])
	}
	
	var actionButtons: some View {
		HStack(spacing: 20) {
			PrimaryButton(
				title: AppStrings.ProductDetail.addToCart,
				backgroundColor: .systemBlue,
				action: addToCart
			)
			
			PrimaryButton(
				title: AppStrings.ProductDetail.buyNow,
				backgroundColor: .secondaryLabel,
				action: {}
			)
		}
		.padding(.top, 20)
	}
	
	var cartBadgeView: some View {
		NavigationLink(destination: CartView()) {
			CartBadgeView(itemCount: cartManager.totalItems())
		}
	}
	
	func addToCart() {
		let currentCount = cartManager.itemCount(for: product)
		if handleQuantityLimit(
			isShown: $showQuantityLimitAlert,
			message: $quantityLimitMessage,
			item: product,
			maxQuantity: product.quantity,
			currentQuantity: currentCount
		) {
			cartManager.addToCart(product)
		}
	}
}

#if DEBUG
#Preview {
	ProductDetailView(product: .lives10)
		.environmentObject(CartManagerViewModel(cartService: CartService()))
}
#endif
