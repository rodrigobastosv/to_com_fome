class Cartao {
  int id;
  String userId;
  String nameCard;
  String numberCard;
  String cvvCard;
  String expirationCard;
  String cpfCard;
  String createdAt;
  String updatedAt;
  Customer customer;

  Cartao(
      {this.id,
      this.userId,
      this.nameCard,
      this.numberCard,
      this.cvvCard,
      this.expirationCard,
      this.cpfCard,
      this.createdAt,
      this.updatedAt,
      this.customer});

  Cartao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nameCard = json['name_card'];
    numberCard = json['number_card'];
    cvvCard = json['cvv_card'];
    expirationCard = json['expiration_card'];
    cpfCard = json['cpf_card'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name_card'] = this.nameCard;
    data['number_card'] = this.numberCard;
    data['cvv_card'] = this.cvvCard;
    data['expiration_card'] = this.expirationCard;
    data['cpf_card'] = this.cpfCard;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Cartao{id: $id, userId: $userId, nameCard: $nameCard, numberCard: $numberCard, cvvCard: $cvvCard, expirationCard: $expirationCard, cpfCard: $cpfCard, createdAt: $createdAt, updatedAt: $updatedAt, customer: $customer}';
  }
}

class Customer {
  int id;
  String name;
  String mobile;
  String address;
  String district;
  String city;
  String state;
  String email;
  Null emailVerifiedAt;
  String password;
  Null rememberToken;
  Null restaurantId;
  String createdAt;
  String updatedAt;

  Customer(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.district,
      this.city,
      this.state,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.restaurantId,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
