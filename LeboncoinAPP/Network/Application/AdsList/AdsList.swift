struct AdsList: AdsListUseCase {
  private let adsRepository: AdsRepository
  
  init(adsRepository: AdsRepository) {
    self.adsRepository = adsRepository
  }
  
  func execute() async throws -> [AdItem] {
    try await adsRepository.fetchAds()
  }
}
