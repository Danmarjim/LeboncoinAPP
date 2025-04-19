struct AdItem: Identifiable {
  let id: Int
  let category: String
  let title: String
  let description: String
  let price: Double
  let smallImageUrl: String
  let thumbnailUrl: String
  let isUrgent: Bool
}
