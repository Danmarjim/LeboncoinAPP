import Foundation

class AdsApiDataSourceMock: AdsDataSource {
  var ads: [AdItem] = []
  var shouldThrowError = false
  
  func fetchAds() async throws -> [AdItem] {
    if shouldThrowError {
      throw NSError(
        domain: "TestError",
        code: 500,
        userInfo: nil
      )
    }
    return ads
  }
}
