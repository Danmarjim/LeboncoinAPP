struct AdItemResponse: Codable {
  let id: Int
  let category: Int
  let title: String
  let description: String
  let price: Double
  let imagesURL: ImagesURLResponse
  let creationDate: String
  let isUrgent: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, title, description, price
    case category = "category_id"
    case imagesURL = "images_url"
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
  }
}
