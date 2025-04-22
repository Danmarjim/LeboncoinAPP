import SwiftUI

class CategoryViewModel: ObservableObject {
  @Published var category: Category
  
  init(category: Category = .empty) {
    self.category = category
  }
  
  func updateCategory(_ value: Category) {
    category = value
  }
}
