import UIKit
import SwiftUI

private enum ViewLayout {
  static let imageSize: CGSize = .init(width: 300, height: 300)
  static let cornerRadius: CGFloat = 25
}

final class AdDetailViewController: UIViewController {
  private let viewModel: AdDetailsViewModel
  private let imageLoader: ImageLoader
  private let categoryModel: CategoryViewModel
  
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
  
  private var adImage: UIImageView = {
    let image = UIImageView()
    image.clipsToBounds = true
    image.layer.cornerRadius = ViewLayout.cornerRadius
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    return image
  }()
  
  private lazy var urgentView: UIHostView<CategoryView> = {
    let rootView = UIHostView(rootView: CategoryView(viewModel: CategoryViewModel(category: .urgent)))
    rootView.translatesAutoresizingMaskIntoConstraints = false
    rootView.hostingController.view.backgroundColor = .clear
    rootView.isHidden = true
    return rootView
  }()
  
  private lazy var categoryView: UIHostView<CategoryView> = {
    return UIHostView(rootView: CategoryView(viewModel: self.categoryModel))
  }()
  
  private var priceLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.textColor = AppColors.primary
    return label
  }()
  
  private var creationDateLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .caption1)
    label.numberOfLines = 0
    return label
  }()
  
  private var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.numberOfLines = 0
    return label
  }()
  
  private var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title3)
    label.numberOfLines = 0
    return label
  }()
  
  private var imageLoadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  private var spacerView: UIView = {
    let view = UIView()
    view.setContentHuggingPriority(.defaultLow, for: .horizontal)
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return view
  }()
  
  private var horizontalStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = Spacing.l
    stack.alignment = .center
    stack.distribution = .fill
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var verticalStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = Spacing.l
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  init(viewModel: AdDetailsViewModel,
       imageLoader: ImageLoader = RemoteImageLoader(),
       categoryModel: CategoryViewModel = CategoryViewModel()) {
    self.viewModel = viewModel
    self.imageLoader = imageLoader
    self.categoryModel = categoryModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    setupView()
    setupContraints()
    configureWithViewModel()
  }
}

// MARK: - SetupUI
extension AdDetailViewController {
  
  private func setupView() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    contentView.addSubview(adImage)
    contentView.addSubview(imageLoadingIndicator)
    contentView.addSubview(urgentView)
    
    horizontalStackView.addArrangedSubview(categoryView)
    horizontalStackView.addArrangedSubview(spacerView)
    horizontalStackView.addArrangedSubview(priceLabel)
    contentView.addSubview(horizontalStackView)
    
    verticalStackView.addArrangedSubview(creationDateLabel)
    verticalStackView.addArrangedSubview(titleLabel)
    verticalStackView.addArrangedSubview(descriptionLabel)
    contentView.addSubview(verticalStackView)
  }
  
  private func setupContraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
        
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
        
    NSLayoutConstraint.activate([
      adImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Spacing.l),
      adImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      adImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.l),
      adImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.l),
      
      adImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
      
      imageLoadingIndicator.centerXAnchor.constraint(equalTo: adImage.centerXAnchor),
      imageLoadingIndicator.centerYAnchor.constraint(equalTo: adImage.centerYAnchor),
      
      urgentView.topAnchor.constraint(equalTo: adImage.topAnchor, constant: Spacing.m),
      urgentView.trailingAnchor.constraint(equalTo: adImage.trailingAnchor, constant: -Spacing.m)
    ])
    
    NSLayoutConstraint.activate([
      horizontalStackView.topAnchor.constraint(equalTo: adImage.bottomAnchor, constant: Spacing.l),
      horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.l),
      horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.l),
    ])
    
    NSLayoutConstraint.activate([
      verticalStackView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: Spacing.l),
      verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.l),
      verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.l),
      verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.l)
    ])
  }
  
  private func configureWithViewModel() {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    categoryModel.updateCategory(viewModel.category)
    priceLabel.text = viewModel.price
    creationDateLabel.text = viewModel.creationDate.formattedForAds()
    
    imageLoadingIndicator.startAnimating()
    imageLoader.loadImage(from: URL(string: viewModel.thumbImage), into: adImage, completion: { [weak self] in
      self?.imageLoadingIndicator.stopAnimating()
      if self?.viewModel.isUrgent ?? false {
        self?.urgentView.isHidden = false
      }
    })
  }
}
