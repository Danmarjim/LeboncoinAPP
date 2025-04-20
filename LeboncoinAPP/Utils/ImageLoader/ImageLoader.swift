import Foundation
import SwiftUI

protocol ImageLoader {
  func loadImage(from url: URL?) -> AnyView
}

struct RemoteImageLoader: ImageLoader {
  func loadImage(from url: URL?) -> AnyView {
    AnyView(
      AsyncImage(url: url) { image in
        image.resizable().scaledToFit()
      } placeholder: {
        ProgressView()
          .frame(maxWidth: .infinity)
      }
    )
  }
}
