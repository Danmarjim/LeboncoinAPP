import SwiftUI

struct CategoryView: View {
  @Binding var selectedCategory: String
  let categories: [String]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 12) {
        ForEach(categories, id: \.self) { category in
          CategoryButton(category: category, isSelected: category == selectedCategory) {
            selectedCategory = category
          }
        }
      }
      .padding(.horizontal)
    }
  }
}

struct CategoryButton: View {
  let category: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(category)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(20)
    }
  }
}

#Preview {
  CategoryView(
    selectedCategory: .constant("Movies"),
    categories: ["All", "Books", "Movies", "Music"]
  )
}
