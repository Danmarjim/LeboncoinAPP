import Foundation

class NetworkService {
  static let shared = NetworkService()
}

extension NetworkService {
  
  var adsList: AdsListUseCase {
    return AdsList(adsRepository: adsRepository)
  }
  
  var adsRepository: AdsRepository {
    return AdsRepository(adsDataSource: AdsApiDataSource())
  }
}
