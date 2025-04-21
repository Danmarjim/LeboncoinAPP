import Foundation
import SwiftUI
import UIKit

protocol ImageLoader {
  func loadImage(from url: URL?) -> AnyView
  func loadImage(from url: URL?, into imageView: UIImageView, completion: @escaping () -> Void)
}

struct RemoteImageLoader: ImageLoader {
  
  func loadImage(from url: URL?) -> AnyView {
    AnyView(
      AsyncImage(url: url) { phase in
        if let image = phase.image {
          image
            .resizable()
            .scaledToFill()
        } else if phase.error != nil {
          Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(AppColors.secondary))
        } else {
          ProgressView()
        }
      }
    )
  }
  
  func loadImage(from url: URL?, into imageView: UIImageView, completion: @escaping () -> Void) {
    guard let url = url else {
      DispatchQueue.main.async {
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = AppColors.secondary
        completion()
      }
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      DispatchQueue.main.async {
        if let data = data, let image = UIImage(data: data) {
          imageView.image = image
        } else {
          imageView.image = UIImage(systemName: "photo")
          imageView.tintColor = AppColors.secondary
        }
        completion()
      }
    }.resume()
  }
}
