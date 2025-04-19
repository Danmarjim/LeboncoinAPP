import Foundation

final class AdsApiDataSource: AdsDataSource {
  private let domainMapper: AdItemDomainMapper
  
  init(domainMapper: AdItemDomainMapper = AdItemDomainMapper()) {
    self.domainMapper = domainMapper
  }
  
  func fetchCategoriesRaw() async throws -> [CategoryResponse] {
    let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
      return try JSONDecoder().decode([CategoryResponse].self, from: data)
    } catch {
      print("Decoding error: \(error)")
      throw error
    }
  }
  
  func fetchAdsRaw() async throws -> [AdItemResponse] {
    let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
      return try JSONDecoder().decode([AdItemResponse].self, from: data)
    } catch {
      print("Decoding error: \(error)")
      throw error
    }
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
