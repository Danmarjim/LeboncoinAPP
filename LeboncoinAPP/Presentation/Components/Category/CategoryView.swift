import SwiftUI

private enum ViewLayout {
  static let cornerRadius: CGFloat = 20
}

struct CategoryView: View {
  @StateObject var viewModel: CategoryViewModel
  
  var body: some View {
    Text(viewModel.category.rawValue)
      .font(.subheadline)
      .foregroundColor(viewModel.category.foregroundColor)
      .padding([.horizontal, .vertical], Spacing.m)
      .background(
        RoundedRectangle(cornerRadius: ViewLayout.cornerRadius)
          .fill(viewModel.category.color)
      )
      .fixedSize()
  }
}

#Preview {
  let viewModel = CategoryViewModel(category: .empty)
  let view = CategoryView(viewModel: viewModel)
  viewModel.updateCategory(.service)
  return view
}
