import Foundation

final class AdsApiDataSource: AdsDataSource {
  private let session: URLSessionProtocol
  private let domainMapper: AdItemDomainMapper
  
  init(session: URLSessionProtocol = URLSession.shared,
       domainMapper: AdItemDomainMapper = AdItemDomainMapper()) {
    self.session = session
    self.domainMapper = domainMapper
  }
  
  func fetchAds() async throws -> [AdItem] {
    async let categoriesTask = fetchCategoriesRaw()
    async let adsTask = fetchAdsRaw()
    
    let (categoriesResponses, adsResponses) = try await (categoriesTask, adsTask)
    let categoryNames = Dictionary(uniqueKeysWithValues: categoriesResponses.map { ($0.id, $0.name) })
    
    return adsResponses.map { response in
      let categoryName = categoryNames[response.category] ?? "Unknown"
      return domainMapper.map(response, categoryName: categoryName)
    }
  }
}

// MARK: - Private methods
extension AdsApiDataSource {
  
  func fetchCategoriesRaw() async throws -> [CategoryResponse] {
    try await fetch(urlString: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")
  }
  
  func fetchAdsRaw() async throws -> [AdItemResponse] {
    try await fetch(urlString: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
  }
  
  private func fetch<T: Decodable>(urlString: String) async throws -> T {
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL(urlString)
    }
    
    let data: Data
    do {
      let (fetchedData, _) = try await session.data(for: URLRequest(url: url))
      data = fetchedData
    } catch {
      throw NetworkError.requestFailed(error)
    }
    
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw NetworkError.decodingFailed(error)
    }
  }
}
