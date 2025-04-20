struct AdItem: Identifiable, Hashable {
  let id: Int
  let category: String
  let title: String
  let description: String
  let price: Double
  let smallImageUrl: String
  let thumbnailUrl: String
  let isUrgent: Bool
}

// MARK: - Mockable
extension AdItem {
  static var mock: AdItem {
    return AdItem(
      id: 1461267313,
      category: "Service",
      title: "Statue homme noir assis en plâtre polychrome",
      description: "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
      price: 140.00,
      smallImageUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
      thumbnailUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
      isUrgent: false)
  }
}
