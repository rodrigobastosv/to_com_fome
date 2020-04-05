class Category {
  int id;
  String name;
  String slug;
  Null description;
  Null image;
  String imagePath;
  String featured;
  String createdAt;
  String updatedAt;

  Category(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.image,
      this.imagePath,
      this.featured,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    imagePath = json['image_path'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image_path'] = this.imagePath;
    data['featured'] = this.featured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, slug: $slug, description: $description, image: $image, imagePath: $imagePath, featured: $featured, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
