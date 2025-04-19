import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
  @Published var items: [AdItem] = []
  
  private let adsList: AdsListUseCase
  
  init(adsList: AdsListUseCase = NetworkService.shared.adsList) {
    self.adsList = adsList
    Task {
      await fetchAdsList()
    }
  }
  
  func fetchAdsList() async {
    do {
      items = try await adsList.execute()
    } catch {
      handleError(error)
    }
  }
}

// MARK: - Private methods
extension HomeViewModel {
  
  private func handleError(_ error: Error) {
    
  }
}
