import SwiftUI

private enum ViewLayout {
  static let cornerRadius: CGFloat = 20
  static let opacity: Double = 0.2
}

struct CategoryView: View {
  @Binding var selectedCategory: String
  let categories: [String]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: Spacing.l) {
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
        .padding(.horizontal, Spacing.l)
        .padding(.vertical, Spacing.s)
        .background(isSelected ? Color.blue : Color.gray.opacity(ViewLayout.opacity))
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(ViewLayout.cornerRadius)
    }
  }
}

#Preview {
  CategoryView(
    selectedCategory: .constant("Movies"),
    categories: ["All", "Books", "Movies", "Music"]
  )
}
