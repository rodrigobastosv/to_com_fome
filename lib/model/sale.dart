class Sale {
  Sale(
      {this.name,
      this.restaurantName,
      this.logoAssetName,
      this.saleAssetImage,
      this.originalPrice,
      this.priceWithDiscount,
      this.discount});

  final String name;
  final String restaurantName;
  final String logoAssetName;
  final String saleAssetImage;
  final int originalPrice;
  final int priceWithDiscount;
  final int discount;
}
