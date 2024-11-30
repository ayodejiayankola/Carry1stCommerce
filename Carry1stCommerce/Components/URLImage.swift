import SwiftUI

struct URLImage: View {
	let url: URL
	let size: CGSize
	
	@StateObject private var imageLoader = ImageLoader()
	
	init(url: URL, size: CGSize) {
		self.url = url
		self.size = size
	}
	
	var body: some View {
		VStack {
			if let uiImage = imageLoader.uiImage {
				Image(uiImage: uiImage)
					.resizable()
					.scaledToFit()
					.frame(width: size.width, height: size.height)
			} else {
				PlaceholderView()
					.frame(width: size.width, height: size.height)
			}
		}
		.task {
			await downloadImage()
		}
	}
	
	private func downloadImage() async {
		do {
			try await imageLoader.fetchImage(url)
		} catch {
			print("Failed to load image: \(error.localizedDescription)")
		}
	}
}

struct PlaceholderView: View {
	var body: some View {
		Color.gray.opacity(0.3)
			.overlay {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
				Text(AppStrings.Common.loading)
					.foregroundColor(.white)
					.font(.caption)
			}
			.cornerRadius(8)
	}
}

#if DEBUG
struct URLImage_Previews: PreviewProvider {
	static var previews: some View {
		URLImage(url: URL(string: Product.credits5000.imageLocation)!, size: CGSize(width: 150, height: 150))
	}
}
#endif
