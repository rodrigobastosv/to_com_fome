import 'package:to_com_fome/model/restaurant_item.dart';

import 'restaurant.dart';

class RestaurantItemOff {
  int id;
  String restaurantId;
  String itemId;
  String active;
  String priceOff;
  String start;
  String end;
  String createdAt;
  String updatedAt;
  RestaurantItem restaurantItem;
  Restaurant restaurant;

  RestaurantItemOff(
      {this.id,
      this.restaurantId,
      this.itemId,
      this.active,
      this.priceOff,
      this.start,
      this.end,
      this.createdAt,
      this.updatedAt,
      this.restaurantItem,
      this.restaurant});

  RestaurantItemOff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    itemId = json['item_id'];
    active = json['active'];
    priceOff = json['price'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantItem =
        json['item'] != null ? RestaurantItem.fromJson(json['item']) : null;
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['item_id'] = this.itemId;
    data['active'] = this.active;
    data['price'] = this.priceOff;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.restaurantItem != null) {
      data['item'] = this.restaurantItem.toJson();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'RestaurantItemOff{id: $id, restaurantId: $restaurantId, itemId: $itemId, active: $active, priceOff: $priceOff, start: $start, end: $end, createdAt: $createdAt, updatedAt: $updatedAt, restaurantItem: $restaurantItem, restaurant: $restaurant}';
  }
}
