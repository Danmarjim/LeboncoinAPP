import SwiftUI

private enum ViewLayout {
  static let cornerRadius: CGFloat = 20
}

struct CategoryView: View {
  @StateObject var viewModel: CategoryViewModel
  
  var body: some View {
    Text(viewModel.category)
      .font(.subheadline)
      .foregroundColor(.white)
      .padding([.horizontal, .vertical], Spacing.m)
      .background(
        RoundedRectangle(cornerRadius: ViewLayout.cornerRadius)
          .fill(Color(AppColors.tertiary))
      )
      .fixedSize()
  }
}

#Preview {
  let viewModel = CategoryViewModel(category: "")
  let view = CategoryView(viewModel: viewModel)
  viewModel.updateCategory("Service")
  return view
}
