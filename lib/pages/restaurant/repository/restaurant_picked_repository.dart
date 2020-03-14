import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
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

  Future<void> saveOrder({
    Order order,
    String address,
    String district,
    String mobile,
    PaymentType paymentType,
  }) async {
    try {
      print('i');
      await client.post(
        '''https://tanamaodelivery.com.br/api/cliente/finalizar-compra?
      name=${order.client.name}&
      email=${order.client.email}&
      address=$address&
      district=$district&
      mobile=$mobile&
      city=${order.client.city}&
      state=${order.client.state}&
      payment_way_id=${paymentType.id}&
      total=${order.totalValue}''',
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
      );
      print('k');
    } catch (e) {
      print(e);
      print(e.toString());
    }
  }
}
