class UserModel {
  int id;
  String name;
  String mobile;
  String address;
  String district;
  String city;
  String state;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.district,
      this.city,
      this.state,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, mobile: $mobile, address: $address, district: $district, city: $city, state: $state, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
