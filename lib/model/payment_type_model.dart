import 'package:equatable/equatable.dart';

class PaymentType extends Equatable {
  int id;
  String name;
  String slug;
  String createdAt;
  String updatedAt;

  PaymentType({this.id, this.name, this.slug, this.createdAt, this.updatedAt});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'PaymentType{id: $id, name: $name, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  List<Object> get props => [id];
}
