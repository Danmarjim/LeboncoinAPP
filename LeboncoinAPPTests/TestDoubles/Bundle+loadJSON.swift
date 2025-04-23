import Foundation

extension Bundle {
  static var test: Bundle {
    Bundle(for: AdsRepositorySpec.self)
  }
  
  static func loadJSONData(named fileName: String) throws -> Data {
    guard let url = Bundle.test.url(forResource: fileName, withExtension: "json") else {
      fatalError("Missing file: \(fileName).json")
    }
    return try Data(contentsOf: url)
  }
}
