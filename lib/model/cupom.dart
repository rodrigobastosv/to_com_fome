import 'package:equatable/equatable.dart';

class Cupom extends Equatable {
  int id;
  String code;
  String value;
  String start;
  String end;
  String createdAt;
  String updatedAt;

  Cupom(
      {this.id,
        this.code,
        this.value,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  Cupom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  List<Object> get props => [id];
}