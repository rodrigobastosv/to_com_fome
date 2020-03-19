class Banner {
  int id;
  String image;
  String imagePath;
  String link;
  String createdAt;
  String updatedAt;

  Banner(
      {this.id,
      this.image,
      this.imagePath,
      this.link,
      this.createdAt,
      this.updatedAt});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    imagePath = json['image_path'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['image_path'] = this.imagePath;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Banner{id: $id, image: $image, imagePath: $imagePath, link: $link, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
