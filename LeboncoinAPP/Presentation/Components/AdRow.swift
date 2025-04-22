import SwiftUI

private enum ViewLayout {
  static let cornerRadius: CGFloat = 20
  static let imageFrame: CGSize = .init(width: 80, height: 80)
}

struct AdRow: View {
  private let imageLoader: ImageLoader
  let ad: AdItem?
  
  init(ad: AdItem? = nil,
       imageLoader: ImageLoader = RemoteImageLoader()) {
    self.ad = ad
    self.imageLoader = imageLoader
  }
  
  var body: some View {
    if let ad = ad {
      HStack(alignment: .top, spacing: Spacing.m) {
        if let url = URL(string: ad.smallImageUrl) {
          imageLoader.loadImage(from: url)
            .frame(width: ViewLayout.imageFrame.width, height: ViewLayout.imageFrame.height)
            .clipShape(RoundedRectangle(cornerRadius: ViewLayout.cornerRadius))
        }
        
        VStack(alignment: .leading, spacing: Spacing.s) {
          Text(ad.title)
            .font(.headline)
          CategoryView(viewModel: CategoryViewModel(category: ad.category))
          Text("\(ad.price, format: .currency(code: "EUR"))")
            .bold()
            .foregroundColor(Color(AppColors.primary))
        }
      }
      .padding(.vertical, Spacing.l)
    } else {
      HStack(alignment: .top, spacing: Spacing.m) {
        SkeletonView(.rect(cornerRadius: ViewLayout.cornerRadius))
          .frame(width: ViewLayout.imageFrame.width, height: ViewLayout.imageFrame.height)
        
        VStack(alignment: .leading, spacing: Spacing.s) {
          SkeletonView(.rect)
            .frame(width: 200, height: 25)
            .padding(.trailing, Spacing.s)
          SkeletonView(.rect(cornerRadius: ViewLayout.cornerRadius))
            .frame(width: 100, height: 30)
          SkeletonView(.rect)
            .frame(width: 100, height: 25)
            .padding(.trailing, Spacing.s)
        }
      }
      .padding(.vertical, Spacing.l)
    }
  }
}

#Preview {
  AdRow(ad: .mock)
}
