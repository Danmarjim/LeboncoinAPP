import Foundation

extension Date {
  
  func formattedForAds() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter.string(from: self)
  }
}
