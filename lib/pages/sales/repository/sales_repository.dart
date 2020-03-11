import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/restaurant_item_off.dart';

class SalesRepository {
  SalesRepository({this.client});

  final Dio client;

  Future<List<RestaurantItemOff>> getItemsOnSale() async {
    try {
      final response = await client.get(
        '/admin/promocoes',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(
          list.length, (i) => RestaurantItemOff.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
