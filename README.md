# Carry1st iOS Commerce App

## Project Overview
A native iOS e-commerce application demonstrating product listing, detailed product views, and cart functionality, built as part of the Carry1st iOS Engineering Assessment.

## 🚀 Features
- **Product Listing**
  - Grid-based display of product bundles
  - Dynamic image loading with caching
  - Product filtering and sorting
- **Product Details**
  - Product information display
  - Add to Cart functionality
  - Cart Quantity tracking for each product
- **Cart Management**
  - Add/remove items
  - Quantity adjustment
  - Total price calculation
  - Persistent cart state across app sessions

## 🏗 Architecture
### Design Patterns
- MVVM (Model-View-ViewModel)
- Protocol-Oriented Programming
- Dependency Injection

### Key Components
- `ProductViewModel`: Manages product data fetching and presentation.
- `CartManagerViewModel`: Handles cart state and operations.
- `CartService`: Business logic for cart management.
- `HTTPClient`: Networking layer for API interactions.

## 📦 Dependency Management
- No external libraries used
- Utilizes native Swift frameworks and SwiftUI

## 🧪 Testing Strategy
### Unit Tests Covered
- **API Service Tests**
  - Handling successful responses
  - Error scenarios
  - Network error management
- **Cart Service Tests**
  - Cart state management
  - Item addition/removal
  - Quantity updates
- **View Model Tests**
  - State initialization
  - Data fetching
  - Error handling

## 🔧 Technical Highlights
- Async/Await for asynchronous operations
- Protocol-based networking for flexibility and testability
- Custom error handling
- Image caching mechanism to improve performance
- Efficient state management with `@Published`, `environmentObject`, and `@StateObject`

## 🌐 API Integration
- Mock JSON server for product data
- Robust error handling and flexible endpoint configuration

## 🎨 UI/UX Considerations
- Light and Dark mode support
- Responsive grid layout for product display
- Dynamic image loading with placeholders for better UX

## 🚧 Performance Optimizations
- Image caching to reduce network calls and enhance performance
- Lazy loading of product images for faster load times
- Minimal view updates for efficient state management

## 📊 System Design Diagram
The app's architecture is designed with modularity and scalability in mind, following principles like separation of concerns and MVVM. The UI layer interacts with ViewModels, which encapsulate presentation logic and mediate between the UI and services. Services handle business logic and API communication, abstracted through protocols for flexibility and testability. Core data models define shared structures, and the network layer manages HTTP requests and error handling. Utilities like `ImageLoader` promote reusability and maintainability.


![Carry1st iOS Assessment  drawio](https://github.com/user-attachments/assets/5ef072d0-a9df-41ac-ab54-b6003b9a1d34)

> A comprehensive architectural diagram showing component interactions, data flow, and system structure.

## 🎥 Demo Videos


### Dark Mode




https://github.com/user-attachments/assets/55e0cb8b-3471-41f9-858b-70fc0e2ca14a




### Light Mode


https://github.com/user-attachments/assets/80fcb923-8cf5-4b21-b6db-c3b375d09285


### Retrying when the internet is back

https://github.com/user-attachments/assets/90653622-3191-4aaf-8f78-720f6536d8fa

## 🔍 Future Improvements
- Offline support for product data and shopping cart
- Enhanced product filtering capabilities
- Persistent cart storage across app launches
- Ability to apply discounts during checkout
- Completing the checkout process
- Improved error handling and user feedback
- UI testing for critical user interactions
- Better handling of internet connectivity with notifications and automatic page reload on reconnect

## 💻 Setup and Installation
1. Clone the repository
	```bash
	git clone https://github.com/ayodejiayankola/Carry1stCommerce.git
	cd Carry1stCommerce
	```
2. Open in Xcode 15+
	```bash
	open Carry1st.xcodeproj
	```
3. Build and run the project on a simulator or device.
	Ensure you're using Xcode 15.0+ and an iOS 17.0+ simulator or device.

## 📋 Prerequisites
- Xcode 15+
- iOS 17+
- Swift 5+

## 🛠 Tools and Technologies
- SwiftUI
- Combine
- Swift Concurrency
- XCTest (for unit testing)

## 📝 Assumptions
1. The mock API provides accurate and stable data.
2. Cart operations are session-based and do not persist across app launches.
3. The "Buy Now" button is a placeholder without functional implementation for this prototype.

