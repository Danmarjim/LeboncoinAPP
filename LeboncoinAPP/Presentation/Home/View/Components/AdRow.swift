import SwiftUI

struct AdRow: View {
  let ad: AdItem
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      if let url = URL(string: ad.smallImageUrl) {
        AsyncImage(url: url) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFill()
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 16))
          case .failure:
            Image(systemName: "photo")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
          case .empty:
            ProgressView()
              .frame(width: 80, height: 80)
          @unknown default:
            EmptyView()
          }
        }
      } else {
        Image(systemName: "photo")
          .resizable()
          .scaledToFit()
          .frame(width: 80, height: 80)
          .foregroundColor(.gray)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        Text(ad.title)
          .font(.headline)
        Text(ad.category)
          .font(.subheadline)
          .foregroundColor(.secondary)
        Text("\(ad.price, format: .currency(code: "EUR"))")
          .bold()
      }
      .padding(.vertical, 8)
    }
  }
}

#Preview {
  AdRow(ad: AdItem(
    id: 1461267313,
    category: "Service",
    title: "Statue homme noir assis en plâtre polychrome",
    description: "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
    price: 140.00,
    smallImageUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
    thumbnailUrl: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
    isUrgent: false)
  )
}
