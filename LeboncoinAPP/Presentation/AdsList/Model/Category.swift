import SwiftUI

enum Category: String, CaseIterable {
  case vehicle = "Véhicule"
  case mode = "Mode"
  case bricolage = "Bricolage"
  case maison = "Maison"
  case loisirs = "Loisirs"
  case immobilier = "Immobilier"
  case livresCDDVD = "Livres/CD/DVD"
  case multimédia = "Multimédia"
  case service = "Service"
  case animaux = "Animaux"
  case enfants = "Enfants"
  case urgent = "Urgent"
  case empty = ""
  
  var color: Color {
    switch self {
    case .urgent:
      return Color(AppColors.urgent)
      
    default:
      return Color(AppColors.tertiary)
    }
  }
  
  var foregroundColor: Color {
    switch self {
    case .urgent:
      return Color(AppColors.urgentForeground)
      
    default:
      return .white
    }
  }
}
