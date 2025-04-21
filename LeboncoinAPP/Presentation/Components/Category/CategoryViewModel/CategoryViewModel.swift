import SwiftUI

class CategoryViewModel: ObservableObject {
  @Published var category: String
  
  init(category: String = "") {
    self.category = category
  }
  
  func updateCategory(_ value: String) {
    category = value
  }
}
