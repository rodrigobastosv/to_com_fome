import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/restaurant_item.dart';

class RestaurantPickedRepository {
  RestaurantPickedRepository({this.client});

  final Dio client;

  Future<List<RestaurantItem>> getItemsRestaurant(String restaurantSlug) async {
    try {
      final response = await client.get(
        'restaurante/$restaurantSlug/cardapios',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(
          list.length, (i) => RestaurantItem.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
