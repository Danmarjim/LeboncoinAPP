import XCTest
@testable import LeboncoinAPP

@MainActor
final class AdsListViewModelSpec: XCTestCase {
  private var sut: AdsListViewModel!
  private var mockUseCase: AdsListUseCaseMock!
  
  override func setUp() {
    super.setUp()
    mockUseCase = AdsListUseCaseMock()
    sut = AdsListViewModel(adsList: mockUseCase)
  }
  
  override func tearDown() {
    mockUseCase = nil
    sut = nil
    super.tearDown()
  }
  
  func test_initial_state() {
    thenInitialState()
  }
  
  func test_fetch_ads_success() async {
    givenAds()
    await whenFetchAds()
    thenSuccessFetchAds()
  }
  
  func test_fetch_ads_failure() async {
    givenError()
    await whenFetchAds()
    thenFailureFetchAds()
  }
}

// MARK: - GIVEN
extension AdsListViewModelSpec {
  
  private func givenAds() {
    let mockItems = [AdItem.mock, AdItem.mock]
    mockUseCase.result = .success(mockItems)
  }
  
  private func givenError() {
    let testError = NSError(domain: "TestError", code: 500, userInfo: nil)
    mockUseCase.result = .failure(testError)
  }
}

// MARK: - WHEN
extension AdsListViewModelSpec {
  
  private func whenFetchAds() async {
    await sut.fetchAdsList()
  }
}

// MARK: - THEN
extension AdsListViewModelSpec {
  
  private func thenInitialState() {
    XCTAssertFalse(sut.isLoading)
    XCTAssertTrue(sut.ads.isEmpty)
    XCTAssertNil(sut.error)
  }
  
  private func thenSuccessFetchAds() {
    XCTAssertFalse(sut.isLoading)
    XCTAssertFalse(sut.ads.isEmpty)
    XCTAssertNil(sut.error)
  }
  
  private func thenFailureFetchAds() {
    XCTAssertFalse(sut.isLoading)
    XCTAssertTrue(sut.ads.isEmpty)
    XCTAssertNotNil(sut.error)
  }
}
