import SwiftUI

private enum ViewLayout {
  static let cornerRadius: CGFloat = 20
  static let opacity: Double = 0.2
  static let skeletonFrame: CGSize = .init(width: 100, height: 30)
}

struct CategoryListView: View {
  @Binding var selectedCategory: String
  let categories: [String]?
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: Spacing.l) {
        if let categories {
          ForEach(categories, id: \.self) { category in
            CategoryButton(category: category, isSelected: category == selectedCategory) {
              selectedCategory = category
            }
          }
        } else {
          ForEach(0..<5, id: \.self) { _ in
            SkeletonView(.rect(cornerRadius: ViewLayout.cornerRadius))
              .frame(width: ViewLayout.skeletonFrame.width, height: ViewLayout.skeletonFrame.height)
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
        .background(isSelected ? Color(AppColors.primary) : Color(AppColors.secondary))
        .foregroundColor(isSelected ? .white : Color(AppColors.primary))
        .cornerRadius(ViewLayout.cornerRadius)
    }
  }
}

#Preview {
  CategoryListView(
    selectedCategory: .constant("Movies"),
    categories: ["All", "Books", "Movies", "Music"]
  )
}
