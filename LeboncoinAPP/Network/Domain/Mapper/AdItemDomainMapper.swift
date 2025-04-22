import Foundation

struct AdItemDomainMapper {
  private let dateFormatter: ISO8601DateFormatter
  
  init() {
    dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
  }
  
  func map(_ item: AdItemResponse, categoryName: String) -> AdItem {
    return AdItem(
      id: item.id,
      category: mapCategory(categoryName),
      title: item.title,
      description: item.description,
      price: item.price,
      smallImageUrl: item.imagesURL.small ?? "",
      thumbnailUrl: item.imagesURL.thumb ?? "",
      creationDate: mapCreationdate(item.creationDate),
      isUrgent: item.isUrgent
    )
  }
}

// MARK: - Private methods
extension AdItemDomainMapper {
  
  private func mapCategory(_ categoryName: String) -> Category {
    return Category(rawValue: categoryName) ?? .empty
  }
  
  private func mapCreationdate(_ creationdate: String) -> Date {
    return dateFormatter.date(from: creationdate) ?? Date()
  }
}
