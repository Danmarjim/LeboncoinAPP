import Foundation

final class URLSessionMock: URLSessionProtocol {
  var mockData: Data
  var mockResponse: URLResponse
  
  init(mockData: Data, mockResponse: URLResponse) {
    self.mockData = mockData
    self.mockResponse = mockResponse
  }
  
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    return (mockData, mockResponse)
  }
}
