import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/restaurant_item.dart';

class RestaurantPickedRepository {
  RestaurantPickedRepository({this.client});

  final Dio client;

  Future<List<RestaurantItem>> getItemsRestaurant(String restaurantId) async {
    try {
      final response = await client.get(
        '$ITENS/$restaurantId',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      return List.generate(decodedResponse.length,
          (i) => RestaurantItem.fromJson(decodedResponse[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
