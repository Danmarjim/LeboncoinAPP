import SwiftUI

@MainActor
class AdsListViewModel: ObservableObject {
  @Published var ads: [AdItem] = []
  @Published var categories: [String] = []
  @Published var selectedCategory = "All"
  @Published var isLoading = false
  @Published var showErrorAlert = false
  private(set) var error: Error?
  
  private let adsList: AdsListUseCase
  
  var filteredAds: [AdItem] {
    selectedCategory == "All" ? ads : ads.filter { $0.category.rawValue == selectedCategory }
  }
  
  init(adsList: AdsListUseCase = NetworkService.shared.adsList) {
    self.adsList = adsList
  }
  
  func fetchAdsList() async {
    isLoading = true
    
#if DEBUG
    try? await Task.sleep(for: .seconds(3))
#endif
    defer { isLoading = false }
    
    do {
      let fetchedAds = try await adsList.execute()
      self.ads = fetchedAds
      prepareCategories(ads: fetchedAds)
    } catch {
      handleError(error)
    }
  }
  
  func retry() {
    Task {
      await fetchAdsList()
    }
  }
}

// MARK: - Private methods
extension AdsListViewModel {
  
  private func handleError(_ error: Error) {
    self.error = error
    showErrorAlert = true
  }
  
  private func prepareCategories(ads: [AdItem]) {
    var uniqueCategories = Array(Set(ads.map { $0.category.rawValue })).sorted()
    uniqueCategories.insert("All", at: 0)
    categories = uniqueCategories
  }
}
