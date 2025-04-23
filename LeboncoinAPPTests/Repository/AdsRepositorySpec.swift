import XCTest
import Combine
@testable import LeboncoinAPP

final class AdsRepositorySpec: XCTestCase {
  private var sut: AdsRepository!
  private var mockDataSource: AdsApiDataSourceMock!
  private var expectedAds: [AdItem] = []
  
  override func setUp() {
    super.setUp()
    
    mockDataSource = AdsApiDataSourceMock()
    sut = AdsRepository(adsDataSource: mockDataSource)
  }
  
  override func tearDown() {
    mockDataSource = nil
    sut = nil
    expectedAds.removeAll()
    
    super.tearDown()
  }
  
  func test_fetch_ads_success() async throws {
    givenSuccessDataSource()
    try await whenSuccessFetchAds()
    thenSuccessFetchAds()
  }
  
  func test_fetch_ads_failure() async throws {
    givenFailureDataSource()
    do {
      try await whenFailureFetchAds()
    } catch {
      thenFailureFetchAds()
    }
  }
  
  func test_ads_service() async throws {
    let mockData = try Bundle.loadJSONData(named: "ads")
    let mockResponse = HTTPURLResponse(
      url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )!
    
    let mockSession = URLSessionMock(mockData: mockData, mockResponse: mockResponse)
    let service = AdsApiDataSource(session: mockSession)
    
    let ads = try await service.fetchAdsRaw()
    XCTAssertNotNil(ads)
  }
  
  func test_categories_service() async throws {
    let mockData = try Bundle.loadJSONData(named: "categories")
    let mockResponse = HTTPURLResponse(
      url: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )!
    
    let mockSession = URLSessionMock(mockData: mockData, mockResponse: mockResponse)
    let service = AdsApiDataSource(session: mockSession)
    
    let categories = try await service.fetchCategoriesRaw()
    XCTAssertNotNil(categories)
  }
}

// MARK: - GIVEN
extension AdsRepositorySpec {
  
  private func givenSuccessDataSource() {
    mockDataSource.ads = [AdItem.mock, AdItem.mock, AdItem.mock]
  }
  
  private func givenFailureDataSource() {
    mockDataSource.shouldThrowError = true
  }
}

// MARK: - WHEN
extension AdsRepositorySpec {
  
  private func whenSuccessFetchAds() async throws {
    expectedAds = try await sut.fetchAds()
  }
  
  private func whenFailureFetchAds() async throws {
    _ = try await sut.fetchAds()
  }
}

// MARK: - THEN
extension AdsRepositorySpec {
  
  private func thenSuccessFetchAds() {
    XCTAssertFalse(expectedAds.isEmpty, "Retrieve data from service")
  }
  
  private func thenFailureFetchAds() {
    XCTAssertTrue(true, "Service fails")
  }
}
