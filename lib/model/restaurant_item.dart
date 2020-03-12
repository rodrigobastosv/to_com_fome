class RestaurantItem {
  int id;
  String restaurantId;
  String categoryId;
  String name;
  String type;
  String description;
  double price;
  String image;
  String imagePath;
  String createdAt;
  String updatedAt;

  RestaurantItem(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.name,
      this.type,
      this.description,
      this.price,
      this.image,
      this.imagePath,
      this.createdAt,
      this.updatedAt});

  RestaurantItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    price = double.parse(json['price'] ?? '0.00');
    image = json['image'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'RestaurantItem{id: $id, restaurantId: $restaurantId, categoryId: $categoryId, name: $name, type: $type, description: $description, price: $price, image: $image, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
