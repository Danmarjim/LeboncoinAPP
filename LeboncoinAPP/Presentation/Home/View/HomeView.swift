import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        if viewModel.isLoading {
          ProgressView()
        } else if let _ = viewModel.error {
          
        } else {
          CategoryView(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories)
            .padding([.top, .bottom], 12)
          List(viewModel.filteredAds) { ad in
            AdRow(ad: ad)
          }
          .listStyle(.insetGrouped)
        }
      }
      .navigationTitle("Leboncoin Ads")
    }
  }
}

#Preview {
  HomeView()
}
