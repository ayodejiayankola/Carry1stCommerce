import SwiftUI

struct PrimaryButton: View {
	var title: String
	var backgroundColor: UIColor
	var action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Text(title)
				.font(.headline)
				.foregroundColor(.white)
				.frame(maxWidth: .infinity)
				.padding()
				.background(Color(uiColor: backgroundColor))
				.cornerRadius(10)
				.shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
		}
	}
}
