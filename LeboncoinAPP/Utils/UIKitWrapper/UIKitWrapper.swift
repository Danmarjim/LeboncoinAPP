import SwiftUI

struct UIKitWrapper<T: UIViewController>: UIViewControllerRepresentable {
  let viewController: () -> T
  
  init(_ viewController: @escaping @autoclosure () -> T) {
    self.viewController = viewController
  }
  
  func makeUIViewController(context: Context) -> UIViewController {
    return viewController()
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
