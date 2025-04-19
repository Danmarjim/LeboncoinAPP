protocol AdsListUseCase {
  func execute() async throws -> [AdItem]
}
