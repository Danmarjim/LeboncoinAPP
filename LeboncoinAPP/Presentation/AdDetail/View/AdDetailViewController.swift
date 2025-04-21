import UIKit
import SwiftUI

private enum ViewLayout {
  static let imageSize: CGSize = .init(width: 300, height: 300)
  static let cornerRadius: CGFloat = 25
}

final class AdDetailViewController: UIViewController {
  private let viewModel: AdDetailsViewModel
  private let imageLoader: ImageLoader
  
  private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isScrollEnabled = true
    scrollView.bounces = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.numberOfLines = 0
    return label
  }()
  
  private var categoryLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .caption1)
    label.numberOfLines = 0
    return label
  }()
  
  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title3)
    label.numberOfLines = 0
    return label
  }()
  
  private var adImage: UIImageView = {
    let image = UIImageView()
    image.clipsToBounds = true
    image.layer.cornerRadius = ViewLayout.cornerRadius
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private var imageLoadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  private var stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = Spacing.l
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  init(viewModel: AdDetailsViewModel,
       imageLoader: ImageLoader = RemoteImageLoader()) {
    self.viewModel = viewModel
    self.imageLoader = imageLoader
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupUI()
    configureWithViewModel()
  }
}

// MARK: - SetupUI
extension AdDetailViewController {
  
  private func setupUI() {
    view.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    scrollView.addSubview(contentView)
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    
    contentView.addSubview(adImage)
    contentView.addSubview(imageLoadingIndicator)
    
    NSLayoutConstraint.activate([
      adImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Spacing.l),
      adImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      adImage.widthAnchor.constraint(equalToConstant: ViewLayout.imageSize.width),
      adImage.heightAnchor.constraint(equalToConstant: ViewLayout.imageSize.height),
      
      imageLoadingIndicator.centerXAnchor.constraint(equalTo: adImage.centerXAnchor),
      imageLoadingIndicator.centerYAnchor.constraint(equalTo: adImage.centerYAnchor)
    ])
    
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(categoryLabel)
    stackView.addArrangedSubview(descriptionLabel)
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: adImage.bottomAnchor, constant: Spacing.l),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.l),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.l),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.l)
    ])
  }
  
  private func configureWithViewModel() {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    categoryLabel.text = viewModel.category
    
    imageLoadingIndicator.startAnimating()
    imageLoader.loadImage(from: URL(string: viewModel.thumbImage), into: adImage, completion: { [weak self] in
      self?.imageLoadingIndicator.stopAnimating()
    })
  }
}
