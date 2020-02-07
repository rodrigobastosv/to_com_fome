class Restaurant {
  String restaurantId;
  String restaurante;
  String logoRestaurante;
  int stars;

  Restaurant(
      {this.restaurantId, this.restaurante, this.logoRestaurante, this.stars});

  Restaurant.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurante = json['restaurante'];
    logoRestaurante = json['logo_restaurante'];
    stars = 4;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurante'] = this.restaurante;
    data['logo_restaurante'] = this.logoRestaurante;
    return data;
  }

  @override
  String toString() {
    return 'Restaurant{restaurantId: $restaurantId, restaurante: $restaurante, logoRestaurante: $logoRestaurante, stars: $stars}';
  }
}
