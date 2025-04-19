struct AdsRepository {
  private let adsDataSource: AdsDataSource
  
  init(adsDataSource: AdsDataSource) {
    self.adsDataSource = adsDataSource
  }
  
  func fetchAds() async throws -> [AdItem] {
    do {
      return try await adsDataSource.fetchAds()
    } catch {
      throw error
    }
  }
}
