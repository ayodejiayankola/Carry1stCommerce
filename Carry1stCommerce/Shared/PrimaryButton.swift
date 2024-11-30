import SwiftUI

struct PrimaryButton: View {
	var title: String
	var backgroundColor: UIColor
	var textColor: UIColor = .white
	var font: Font = .headline
	var shadowColor: Color = .black.opacity(0.1)
	var action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Text(title)
				.font(font)
				.foregroundColor(Color(uiColor: textColor))
				.frame(maxWidth: .infinity)
				.padding()
				.background(Color(uiColor: backgroundColor))
				.cornerRadius(10)
				.shadow(color: shadowColor, radius: 3, x: 0, y: 2)
		}
	}
}

