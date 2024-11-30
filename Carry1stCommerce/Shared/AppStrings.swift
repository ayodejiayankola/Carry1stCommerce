import SwiftUI

enum AppStrings {
	enum Endpoint {
		static let scheme = NSLocalizedString("https", comment: "The URL scheme")
	}
	
	enum Error {
		static let invalidURL = NSLocalizedString("The URL provided is invalid.", comment: "Error when the provided URL is malformed or not reachable.")
		static let noResponse = NSLocalizedString("No response received from the server.", comment: "Error when the server does not respond to the request.")
		static let unauthorized = NSLocalizedString("Unauthorized access.", comment: "Error when the user is not authorized to access the requested resource.")
		static let unexpectedStatusCode = NSLocalizedString("Unexpected status code from the server.", comment: "Error when the server returns an unexpected HTTP status code.")
		static let decode = NSLocalizedString("Failed to decode the response.", comment: "Error when decoding the server's response data fails.")
		static let invalidData = NSLocalizedString("The data received from the server is invalid.", comment: "Error when the data received from the server is not in the expected format or is corrupted.")
		static let unknownError = NSLocalizedString("An unknown error occurred.", comment: "Error for any unknown or unexpected error that doesn’t fall into the above categories.")
	}
	
	enum Common {
		static let loading = NSLocalizedString("Loading...", comment: "Text displayed when image is loading")
		static let retry = NSLocalizedString("Retry", comment: "Text displayed network fail and you will like to click a button to refresh")
	}
	enum QuantityLimitAlert {
		static let maximumStockLimitReached = NSLocalizedString("Oops! Maximum stock limit reached", comment: "Message when maximum stock limit is reached")
		static let noMoreItemsAvailable = NSLocalizedString("Sorry, no more items available", comment: "Message when no more items are available")
		static let maximumQuantityExceeded = NSLocalizedString("Maximum quantity exceeded", comment: "Message when maximum quantity is exceeded")
		static let stockLimitHit = NSLocalizedString("Stock limit hit for this item", comment: "Message when stock limit is hit")
		static let cantAddMoreProduct = NSLocalizedString("Can't add more of this product", comment: "Message when product can't be added more")
		static let maximumAvailableQuantity = NSLocalizedString("Reached maximum available quantity", comment: "Message when maximum available quantity is reached")
		static let maximumQuantityReached = NSLocalizedString("Maximum quantity reached", comment: "Message when maximum quantity is reached")
		static let maximumQuantityForProduct = NSLocalizedString("Maximum quantity reached for %@", comment: "Message when maximum quantity is reached for a product")
	}
	
	enum ProductViewModel {
		static let fetchProductsErrorMessage = NSLocalizedString("An error occurred while fetching products.", comment: "Error message when fetching products fails")
	}
	
	enum ProductList {
		static let loadingProducts = NSLocalizedString("Loading products...", comment: "Message displayed when products are loading")
		static let errorMessage = NSLocalizedString("Error loading products", comment: "Error message when fetching products fails")
		static let navigationTitle = NSLocalizedString("Carry1st Commerce", comment: "Title for the product list screen")
	}
	
	enum ProductDetail {
		static let addToCart = NSLocalizedString("Add to Cart", comment: "Button text to add product to cart")
		static let buyNow = NSLocalizedString("Buy Now", comment: "Button text for immediate purchase")
		static let inCart = NSLocalizedString("In Cart: ", comment: "Label showing the number of items in cart")
	}
	
	enum CartView {
		static let cartTitle = NSLocalizedString("Cart", comment: "Cart screen title")
		static let emptyCartMessage = NSLocalizedString("Your cart is empty", comment: "Message when the cart is empty")
		static let emptyCartDescription = NSLocalizedString("Looks like you haven't added anything to your cart yet. Start exploring and find something you like!", comment: "Description for empty cart")
		static let totalLabel = NSLocalizedString("Total", comment: "Label for the total amount in the cart")
		static let contineButtonLabel = NSLocalizedString("Continue Shopping", comment: "Label for the text on the button in empty cart state")
	}
}
