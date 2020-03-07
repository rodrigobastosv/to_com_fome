class Restaurant {
  int id;
  String name;
  String slug;
  String address;
  String number;
  String district;
  String state;
  String city;
  String openingHoursStart;
  String openingHoursEnd;
  String deliveryTime;
  String valueMin;
  String tax;
  String paymentWayId;
  String phone;
  String mobile;
  String whatsapp;
  String logo;
  String logoPath;
  String cnpj;
  String inscEst;
  String info;
  String aboutUs;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Restaurant(
      {this.id,
      this.name,
      this.slug,
      this.address,
      this.number,
      this.district,
      this.state,
      this.city,
      this.openingHoursStart,
      this.openingHoursEnd,
      this.deliveryTime,
      this.valueMin,
      this.tax,
      this.paymentWayId,
      this.phone,
      this.mobile,
      this.whatsapp,
      this.logo,
      this.logoPath,
      this.cnpj,
      this.inscEst,
      this.info,
      this.aboutUs,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    address = json['address'];
    number = json['number'];
    district = json['district'];
    state = json['state'];
    city = json['city'];
    openingHoursStart = json['opening_hours_start'];
    openingHoursEnd = json['opening_hours_end'];
    deliveryTime = json['delivery_time'];
    valueMin = json['value_min'];
    tax = json['tax'];
    paymentWayId = json['payment_way_id'];
    phone = json['phone'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    logo = json['logo'];
    logoPath = json['logo_path'];
    cnpj = json['cnpj'];
    inscEst = json['insc_est'];
    info = json['info'];
    aboutUs = json['about_us'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['address'] = this.address;
    data['number'] = this.number;
    data['district'] = this.district;
    data['state'] = this.state;
    data['city'] = this.city;
    data['opening_hours_start'] = this.openingHoursStart;
    data['opening_hours_end'] = this.openingHoursEnd;
    data['delivery_time'] = this.deliveryTime;
    data['value_min'] = this.valueMin;
    data['tax'] = this.tax;
    data['payment_way_id'] = this.paymentWayId;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['whatsapp'] = this.whatsapp;
    data['logo'] = this.logo;
    data['logo_path'] = this.logoPath;
    data['cnpj'] = this.cnpj;
    data['insc_est'] = this.inscEst;
    data['info'] = this.info;
    data['about_us'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Restaurant{id: $id, name: $name, slug: $slug, address: $address, number: $number, district: $district, state: $state, city: $city, openingHoursStart: $openingHoursStart, openingHoursEnd: $openingHoursEnd, deliveryTime: $deliveryTime, valueMin: $valueMin, tax: $tax, paymentWayId: $paymentWayId, phone: $phone, mobile: $mobile, whatsapp: $whatsapp, logo: $logo, logoPath: $logoPath, cnpj: $cnpj, inscEst: $inscEst, info: $info, aboutUs: $aboutUs, createdAt: $createdAt, updatedAt: $updatedAt, pivot: $pivot}';
  }
}

class Pivot {
  String categoryId;
  String restaurantId;
  String createdAt;
  String updatedAt;

  Pivot({this.categoryId, this.restaurantId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
