### Carry1st iOS Commerce App  

#### Project Overview  
The Carry1st iOS Commerce App is a native SwiftUI e-commerce application that showcases modern iOS engineering best practices. It includes product listing, detailed product views, and cart functionality, developed as part of the Carry1st iOS Engineering Assessment.  

---

### 🏷️ Tag: v1.0  
**Initial release** featuring a quick prototype implementation of the app's core functionality.  

---

### 📝 Release Notes  

#### 🚀 Features  
- **Product Listing**:  
  - Grid layout using `LazyVGrid` for efficient product display.  
  - Dynamic image loading with caching for seamless user experience.  

- **Product Details**:  
  - Product information required shown.  
  - "Add to Cart" functionality with real-time cart updates.  

- **Cart Management**:  
  - Manage items with quantity adjustments and limits.  
  - Real-time total price calculation.  
  - Persistent cart state across sessions, ensuring continuity even after app restarts.  
  - User-friendly empty cart state with navigation options.  

- **Localization**:  
  - Centralized string management supports future multiple languages for global scalability.  

---

### 🏗 Architecture  

#### **Design Patterns**  
- **MVVM (Model-View-ViewModel)**: Decouples UI and business logic for maintainability.  
- **Protocol-Oriented Programming**: Ensures modular and testable components.  
- **Dependency Injection**: Simplifies testing and promotes clean code.  

#### **Key Components**  
- `ProductViewModel`: Handles product data fetching and state presentation.  
- `CartManagerViewModel`: Orchestrates cart operations and updates.  
- `CartService`: Encapsulates business logic for cart state management.  
- `HTTPClient`: Manages API requests and error handling.  

---

### 📦 Dependency Management  
This app relies exclusively on **native Swift frameworks** to ensure efficiency and alignment with Apple’s ecosystem.  

---

### 🧪 Testing Strategy  

#### **Unit Tests**  
- **Networking Layer**: Verifies successful responses, error handling, and recovery strategies.  
- **Cart Management**: Validates item addition, removal, quantity adjustments, and price calculations.  
- **ViewModels**: Tests state initialization, data fetching, and error handling.  

#### **Tools**  
- XCTest for comprehensive test coverage across all layers of the app.  

---

### 🔧 Technical Highlights  
- **Modern Swift Concurrency**: Async/await simplifies asynchronous operations.  
- **Robust Networking Layer**:  
  - Protocol-based architecture enables flexibility and testability.  
  - Unified `RequestError` handles all network-related issues with user-friendly feedback.  
- **Efficient State Management**: USing `@Published`, `@StateObject`, and `EnvironmentObject` for dynamic UI updates.  
- **Image Caching**: Improving performance by reducing redundant network calls.  
- **Dynamic Light/Dark Mode**: Seamlessly adapts to user preferences.  

---

### 🌐 API Integration  
- Utilizes a mock JSON server for consistent product data.  
- Flexible endpoint configuration to simplify future integration.  

---

### 🎨 UI/UX Design  
- **Dark and Light Mode**: Ensures optimal readability in all conditions.  
- **Responsive Layouts**: Intuitive grid design adapts to various screen sizes.  
- **Error Feedback**: Clear, actionable messages guide users during connectivity issues.  

---

### 🚧 Performance Optimizations  
- **Image Caching**: Reduces load times and optimizes network usage.  
- **Lazy Loading**: Ensures smooth scrolling and faster initial load times.  
- **Optimized State Management**: Minimizes unnecessary view updates, improving app responsiveness.  

---

### 🔍 Future Improvements  
- Offline support for products and cart functionality.  
- Advanced product filtering and sorting options.  
- Persistent cart storage using Core Data or Realm.  
- Discount and promotion application at checkout.  
- Complete checkout implementation for a seamless e-commerce experience.  

---

### 💻 Setup and Installation  

1. Clone the repository:  
   ``
   git clone https://github.com/ayodejiayankola/Carry1stCommerce.git  
   ```  
2. Navigate to the project directory:  
   ``` 
   cd Carry1stCommerce  
   ```  
3. Open the project in Xcode:  
   ``` 
   open Carry1stCommerce.xcodeproj  
   ```  
4. Build and run on an iOS 17+ simulator or device using Xcode 15+.  

---

### 📋 Prerequisites  
- Xcode 15+  
- iOS 17+  
- Swift 5+  

---

### 🎥 Demo Videos  

#### Dark Mode  
[Watch Demo](https://github.com/user-attachments/assets/55e0cb8b-3471-41f9-858b-70fc0e2ca14a)  

#### Light Mode  
[Watch Demo](https://github.com/user-attachments/assets/80fcb923-8cf5-4b21-b6db-c3b375d09285)  

#### Retry on Internet Reconnection  
[Watch Demo](https://github.com/user-attachments/assets/90653622-3191-4aaf-8f78-720f6536d8fa)  

---

### 📊 System Design Diagram  
The app architecture emphasizes modularity and scalability. It follows MVVM principles, where the UI layer interacts exclusively with ViewModels. These ViewModels mediate between the UI and service layers, ensuring clean separation of concerns.  

![System Design](https://github.com/user-attachments/assets/5ef072d0-a9df-41ac-ab54-b6003b9a1d34)  

## 📝 Assumptions
1. The mock API provides accurate and stable data.
2. Cart operations are session-based and do not persist across app launches.
3. The "Buy Now" button is a placeholder without functional implementation for this prototype.

