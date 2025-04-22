import SwiftUI

struct AdsListView: View {
  @StateObject private var viewModel = AdsListViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        if viewModel.isLoading {
          ProgressView()
        } else if let error = viewModel.error {
          VStack {
            Text("Something went wrong:")
              .font(.headline)
            Text(error.localizedDescription)
              .font(.subheadline)
            Button("Retry") {
              viewModel.retry()
            }
            .padding(.top)
          }
        } else {
          CategoryListView(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
            .padding([.top, .bottom], Spacing.m)
          
          List(viewModel.filteredAds) { ad in
            NavigationLink(value: ad) {
              AdRow(ad: ad)
            }
          }
        }
      }
      .navigationTitle("Ads List")
      .navigationDestination(for: AdItem.self) { selectedAd in
        let viewController = AdDetailViewController(viewModel: AdDetailsViewModel(ad: selectedAd))
        UIKitWrapper(viewController)
      }
    }
    .task {
      await viewModel.fetchAdsList()
    }
  }
}

#Preview {
  AdsListView()
}
