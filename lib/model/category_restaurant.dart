import 'restaurant.dart';

class CategoryRestaurant {
  String id;
  String name;
  String image;
  List<Restaurant> restaurants;

  CategoryRestaurant({this.id, this.name, this.image, this.restaurants});

  CategoryRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['restaurantes'] != null) {
      restaurants = List<Restaurant>();
      json['restaurantes'].forEach((v) {
        restaurants.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.restaurants != null) {
      data['restaurantes'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
