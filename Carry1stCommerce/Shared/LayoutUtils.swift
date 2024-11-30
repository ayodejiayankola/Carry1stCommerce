import SwiftUI

struct LayoutUtils {
	static var screenWidth: CGFloat {
		UIScreen.main.bounds.width
	}
	
	static func gridImageWidth(for columns: Int, padding: CGFloat = 32) -> CGFloat {
		return (screenWidth - padding) / CGFloat(columns)
	}
}
