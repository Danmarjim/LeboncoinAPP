import Foundation

extension Date {
  
  func formattedForAds() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "fr_FR")
    return formatter.string(from: self)
  }
}
