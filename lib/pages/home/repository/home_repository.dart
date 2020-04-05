import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/banner.dart';
import 'package:to_com_fome/model/category_restaurant.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/payment_type_model.dart';

class HomeRepository {
  HomeRepository({this.client});

  final Dio client;

  Future<List<CategoryRestaurant>> getCategoryRestaurant() async {
    try {
      final response = await client.get(
        '$ADMIN/$CATEGORIES?featured=Sim',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(
          list.length, (i) => CategoryRestaurant.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<PaymentType>> getPaymentTypes() async {
    try {
      final response = await client.get(
        '$ADMIN/$FORMA_PAGAMENTOS',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(list.length, (i) => PaymentType.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Cupom>> getCupoms() async {
    try {
      final response = await client.get(
        '$ADMIN/cupoms',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(list.length, (i) => Cupom.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Banner>> getBanners() async {
    try {
      final response = await client.get(
        '$ADMIN/banners',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(list.length, (i) => Banner.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
