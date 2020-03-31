class FavoriteRestaurant {
  int id;
  String name;
  String logo;
  String logoPath;
  String createdAt;
  String updatedAt;
  int countOrders;
  String lastOrder;

  FavoriteRestaurant(
      {this.id,
      this.name,
      this.logo,
      this.logoPath,
      this.createdAt,
      this.updatedAt,
      this.countOrders,
      this.lastOrder});

  FavoriteRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    logoPath = json['logo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countOrders = json['countOrders'];
    lastOrder = json['lastOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['logo_path'] = this.logoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['countOrders'] = this.countOrders;
    data['lastOrder'] = this.lastOrder;
    return data;
  }
}
