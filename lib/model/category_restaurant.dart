import 'restaurant.dart';

class CategoryRestaurant {
  int id;
  String name;
  String slug;
  String description;
  String image;
  String imagePath;
  String createdAt;
  String updatedAt;
  List<Restaurant> restaurants;

  CategoryRestaurant(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.image,
      this.imagePath,
      this.createdAt,
      this.updatedAt,
      this.restaurants});

  CategoryRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['restaurants'] != null) {
      restaurants = List<Restaurant>();
      json['restaurants'].forEach((v) {
        restaurants.add(Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image_path'] = this.imagePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
