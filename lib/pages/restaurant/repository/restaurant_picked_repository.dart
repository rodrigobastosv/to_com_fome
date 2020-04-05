import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/category_group.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/model/user_model.dart';

class RestaurantPickedRepository {
  RestaurantPickedRepository({this.client});

  final Dio client;

  Future<List<CategoryGroup>> getItemsRestaurant(String restaurantSlug) async {
    try {
      final response = await client.get(
        'restaurante/$restaurantSlug/restaurante_categorias',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final data = decodedResponse['data'];
      final list = data['categories'] as List;
      final listCategories =
          List.generate(list.length, (i) => CategoryGroup.fromJson(list[i]));
      return listCategories
          .where((categories) => (categories.restaurantItems ?? []).isNotEmpty)
          .toList();
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
      "restaurant_id": restaurant.id,
      'coupon_id': cupom?.id,
      'total': order.totalValue,
      'total_final': order.totalValue,
      'info': order.items.map((item) => item.obs).toString(),
      'payment_way_id': paymentType.id,
      'user_id': cliente.id,
      'delivery_address': address,
      'items': order.items.map((item) {
        return {
          'id': item.id,
          'price': item.value,
          'restaurant_id': restaurant.id,
          'category_id': item.categoryId,
          'type': item.type,
          'name': item.name,
          'description': item.obs,
          'promotion_id': ""
        };
      }).toList(),
    };
    print(orderJson);
    try {
      await client.post(
        'https://tanamaodelivery.com.br/api/cliente/finalizar-compra',
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
        data: jsonEncode(orderJson),
      );
    } catch (e) {
      print(e);
      print(e.toString());
    }
  }
}
