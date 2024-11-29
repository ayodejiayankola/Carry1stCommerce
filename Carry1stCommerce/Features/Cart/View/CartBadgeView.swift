import SwiftUI

struct CartBadgeView: View {
	var itemCount: Int

	private let badgeSize: CGFloat = 18
	private let fontSize: CGFloat = 12
	private let cartIconSize: CGFloat = 20
	private let badgeOffset: CGSize = CGSize(width: 12, height: -10)

	var body: some View {
		ZStack(alignment: .topTrailing) {
			Image(systemName: "cart")
				.resizable()
				.scaledToFit()
				.frame(width: cartIconSize, height: cartIconSize)
				.symbolVariant(itemCount > 0 ? .fill : .none)
				.symbolEffect(.bounce, value: itemCount)

			if itemCount > 0 {
				Text("\(itemCount)")
					.font(.system(size: fontSize, weight: .bold))
					.foregroundColor(.white)
					.frame(width: badgeSize, height: badgeSize)
					.background(Color.red)
					.clipShape(Circle())
					.offset(badgeOffset)
					.transition(.scale)
					.animation(.bouncy, value: itemCount)
					.accessibilityLabel("Cart items")
					.accessibilityValue("\(itemCount) items")
			}
		}
	}
}


#if DEBUG
#Preview {
	Group {
		CartBadgeView(itemCount: 10)
		CartBadgeView(itemCount: 0)
	}
}
#endif
