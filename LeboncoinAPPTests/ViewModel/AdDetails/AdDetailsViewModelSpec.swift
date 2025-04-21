import XCTest
@testable import LeboncoinAPP

final class AdDetailsViewModelSpec: XCTestCase {
  private var sut: AdDetailsViewModel!
  
  override func setUp() {
    super.setUp()
    sut = AdDetailsViewModel(ad: .mock)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_initialization() {
    thenInitializationSucceeds()
  }
}

// MARK: - THEN
extension AdDetailsViewModelSpec {
  
  private func thenInitializationSucceeds() {
    XCTAssertNotNil(sut)
    XCTAssertFalse(sut.title.isEmpty)
    XCTAssertFalse(sut.description.isEmpty)
    XCTAssertFalse(sut.category.isEmpty)
    XCTAssertFalse(sut.price.isEmpty)
    XCTAssertFalse(sut.thumbImage.isEmpty)
    XCTAssertNotNil(sut.isUrgent)
  }
}
