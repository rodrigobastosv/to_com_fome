import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/favorite_restaurant.dart';

class FavoriteRestaurantRepository {
  FavoriteRestaurantRepository({this.client});

  final Dio client;

  Future<List<FavoriteRestaurant>> getFavoriteRestaurants(
      String clienteId) async {
    try {
      final response = await client.get(
        'cliente/$clienteId/restaurantes',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(
          list.length, (i) => FavoriteRestaurant.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
