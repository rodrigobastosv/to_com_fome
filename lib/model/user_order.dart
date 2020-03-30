class UserOrder {
  int id;
  String userId;
  String restaurantId;
  String restaurantName;
  String paymentWayId;
  String total;
  String couponId;
  String couponCode;
  String couponValue;
  String totalFinal;
  String status;
  String info;
  String deliveryAddress;
  String createdAt;
  String updatedAt;
  List<UserOrderItems> items;

  UserOrder(
      {this.id,
      this.userId,
      this.restaurantId,
      this.restaurantName,
      this.paymentWayId,
      this.total,
      this.couponId,
      this.couponCode,
      this.couponValue,
      this.totalFinal,
      this.status,
      this.info,
      this.deliveryAddress,
      this.createdAt,
      this.updatedAt,
      this.items});

  UserOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    paymentWayId = json['payment_way_id'];
    total = json['total'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    couponValue = json['coupon_value'];
    totalFinal = json['total_final'];
    status = json['status'];
    info = json['info'];
    deliveryAddress = json['delivery_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = new List<UserOrderItems>();
      json['items'].forEach((v) {
        items.add(new UserOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['payment_way_id'] = this.paymentWayId;
    data['total'] = this.total;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['coupon_value'] = this.couponValue;
    data['total_final'] = this.totalFinal;
    data['status'] = this.status;
    data['info'] = this.info;
    data['delivery_address'] = this.deliveryAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserOrderItems {
  int id;
  String restaurantId;
  String categoryId;
  String name;
  String type;
  String description;
  String price;
  String image;
  String imagePath;
  String promotionId;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  UserOrderItems(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.name,
      this.type,
      this.description,
      this.price,
      this.image,
      this.imagePath,
      this.promotionId,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  UserOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    imagePath = json['image_path'];
    promotionId = json['promotion_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['image_path'] = this.imagePath;
    data['promotion_id'] = this.promotionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String orderId;
  String itemId;

  Pivot({this.orderId, this.itemId});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_id'] = this.itemId;
    return data;
  }
}
