struct AdItemDomainMapper {
  func map(_ item: AdItemResponse, categoryName: String) -> AdItem {
    return AdItem(
      id: item.id,
      category: categoryName,
      title: item.title,
      description: item.description,
      price: item.price,
      smallImageUrl: item.imagesURL.small ?? "",
      thumbnailUrl: item.imagesURL.thumb ?? "",
      isUrgent: item.isUrgent
    )
  }
}
