import SwiftUI

private enum ViewLayout {
  static let width: CGFloat = 80
  static let height: CGFloat = 80
  static let cornerRadius: CGFloat = 16
}

struct AdRow: View {
  private let imageLoader: ImageLoader
  let ad: AdItem
  
  init(ad: AdItem,
       imageLoader: ImageLoader = RemoteImageLoader()) {
    self.ad = ad
    self.imageLoader = imageLoader
  }
  
  var body: some View {
    HStack(alignment: .top, spacing: Spacing.m) {
      if let url = URL(string: ad.smallImageUrl) {
        imageLoader.loadImage(from: url)
          .frame(width: ViewLayout.width, height: ViewLayout.height)
          .clipShape(RoundedRectangle(cornerRadius: ViewLayout.cornerRadius))
      }
      
      VStack(alignment: .leading, spacing: Spacing.s) {
        Text(ad.title)
          .font(.headline)
        Text(ad.category)
          .font(.subheadline)
          .foregroundColor(.secondary)
        Text("\(ad.price, format: .currency(code: "EUR"))")
          .bold()
      }
    }
    .padding(.vertical, Spacing.l)
  }
}

#Preview {
  AdRow(ad: .mock)
}
