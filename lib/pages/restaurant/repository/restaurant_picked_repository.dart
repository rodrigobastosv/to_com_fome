import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/model/restaurant_item.dart';
import 'package:to_com_fome/model/user_model.dart';

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
    Restaurant restaurant,
    Order order,
    String address,
    String district,
    String mobile,
    UserModel cliente,
    Cupom cupom,
    PaymentType paymentType,
  }) async {
    Map orderJson = {
      'coupon_id': cupom?.id,
      'total': order.totalValue,
      'total_final': order.totalValue,
      'info': order.items.map((item) => item.obs).toList().toString(),
      'payment_way_id': paymentType.id,
      'id_cliente': cliente.id,
      'delivery_address': address,
      'itens': order.items.map((item) {
        return {
          'id': item.id,
          "restaurant_id": restaurant.id,
          "category_id": item.categoryId,
          "type": item.type,
          "name": item.name,
          "description": item.obs,
          "promotion_id": ""
        };
      }).toList(),
    };
    print(orderJson);
    try {
      final response = await client.post(
        'https://tanamaodelivery.com.br/api/cliente/finalizar-compra',
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
        data: jsonEncode(orderJson),
      );
      print(response);
      print(response.data);
    } catch (e) {
      print(e);
      print(e.toString());
    }
  }
}
