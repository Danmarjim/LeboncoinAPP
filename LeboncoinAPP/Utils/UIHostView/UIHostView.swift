import SwiftUI
import UIKit

class UIHostView<Content: View>: UIView {
  private let hostingController: UIHostingController<Content>
  
  init(rootView: Content) {
    self.hostingController = UIHostingController(rootView: rootView)
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(hostingController.view)
    
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}
