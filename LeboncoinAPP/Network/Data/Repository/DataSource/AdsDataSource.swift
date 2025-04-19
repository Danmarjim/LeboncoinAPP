protocol AdsDataSource {
  func fetchAds() async throws -> [AdItem]
}
