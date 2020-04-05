import 'package:to_com_fome/model/category.dart';

import 'restaurant.dart';
import 'restaurant_item.dart';

class CategoryGroup {
  int id;
  String restaurantId;
  String categoryId;
  String categoryName;
  String createdAt;
  String updatedAt;
  List<RestaurantItem> restaurantItems;
  Restaurant restaurant;
  Category category;

  CategoryGroup(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.categoryName,
      this.createdAt,
      this.updatedAt,
      this.restaurantItems,
      this.restaurant,
      this.category});

  CategoryGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    categoryName = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      restaurantItems = new List<RestaurantItem>();
      json['items'].forEach((v) {
        restaurantItems.add(new RestaurantItem.fromJson(v));
      });
    }
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    data['name'] = this.categoryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantItems != null) {
      data['items'] = this.restaurantItems.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'CategoryGroup{id: $id, restaurantId: $restaurantId, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, restaurantItems: $restaurantItems, restaurant: $restaurant, category: $category}';
  }
}
