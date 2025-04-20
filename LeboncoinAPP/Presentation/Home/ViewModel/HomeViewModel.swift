import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
  @Published var ads: [AdItem] = []
  @Published var categories: [String] = []
  @Published var selectedCategory = "All"
  @Published var isLoading = false
  @Published var error: Error?
  
  private let adsList: AdsListUseCase
  
  var filteredAds: [AdItem] {
    selectedCategory == "All" ? ads : ads.filter { $0.category == selectedCategory }
  }
  
  init(adsList: AdsListUseCase = NetworkService.shared.adsList) {
    self.adsList = adsList
    Task {
      await fetchAdsList()
    }
  }
  
  func fetchAdsList() async {
    isLoading = true
    defer { isLoading = false }
    
    do {
      ads = try await adsList.execute()
      prepareCategories(ads: ads)
    } catch {
      handleError(error)
    }
  }
}

// MARK: - Private methods
extension HomeViewModel {
  
  private func handleError(_ error: Error) {
    
  }
  
  private func prepareCategories(ads: [AdItem]) {
    var uniqueCategories = Array(Set(ads.map { $0.category })).sorted()
    uniqueCategories.insert("All", at: 0)
    categories = uniqueCategories
  }
}
