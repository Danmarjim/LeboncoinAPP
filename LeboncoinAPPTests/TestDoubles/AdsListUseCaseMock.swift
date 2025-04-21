class AdsListUseCaseMock: AdsListUseCase {
  var result: Result<[AdItem], Error> = .success([])
  
  func execute() async throws -> [AdItem] {
    switch result {
    case .success(let items):
      return items
      
    case .failure(let error):
      throw error
    }
  }
}
