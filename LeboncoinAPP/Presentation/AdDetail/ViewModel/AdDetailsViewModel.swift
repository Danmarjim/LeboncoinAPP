import Foundation

class AdDetailsViewModel {
  private let ad: AdItem
  
  init(ad: AdItem) {
    self.ad = ad
  }
  
  var title: String { return ad.title }
  var description: String { return ad.description }
  var category: Category { return ad.category }
  var price: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "EUR"
    return formatter.string(from: NSNumber(value: ad.price)) ?? "\(ad.price) €"
  }
  var thumbImage: String { return ad.thumbnailUrl }
  var creationDate: Date { return ad.creationDate }
  var isUrgent: Bool { return ad.isUrgent }
}
