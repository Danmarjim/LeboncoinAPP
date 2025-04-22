import Foundation

enum NetworkError: Error {
  case invalidURL(String)
  case requestFailed(_ error: Error)
  case decodingFailed(Error)
}
