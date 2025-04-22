# Leboncoin - iOS Technical Challenge

📱 A modern iOS application showcasing classified ads, built with SwiftUI and UIKit, demonstrating clean architecture and best practices.

## 🏆 Features

- **Dual UI Framework Integration**: Seamless combination of SwiftUI and UIKit components
- **Modern Architecture**: MVVM pattern with Repository layer
- **Full Test Coverage**: Robust unit testing
- **Adaptive UI**: Responsive design for all device sizes

## 🏗️ Architecture Overview

### � MVVM + Repository Pattern
**Clean separation of concerns** with three distinct layers:

1. **Presentation Layer** (SwiftUI/UIKit)
   - Views observe ViewModel `@Published` properties
   - UIKit views wrapped for SwiftUI compatibility
   - SwiftUI components embedded in UIKit via `UIHostingController`

2. **Domain Layer**
   - Business logic in ViewModels
   - Model transformations
   - Use cases

3. **Data Layer** (Repository Pattern)
   - Abstract network and persistence operations
   - Swappable data sources (API, Mock)
   - Complete API-to-domain model isolation
