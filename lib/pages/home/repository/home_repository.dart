import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/category_restaurant.dart';

class HomeRepository {
  HomeRepository({this.client});

  final Dio client;

  Future<List<CategoryRestaurant>> getCategoryRestaurant() async {
    try {
      final response = await client.get(
        CATEGORIES,
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      return List.generate(decodedResponse.length,
          (i) => CategoryRestaurant.fromJson(decodedResponse[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
