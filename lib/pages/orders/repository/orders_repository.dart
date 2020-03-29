import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/user_order.dart';

import '../../../model/user_model.dart';

class OrdersRepository {
  OrdersRepository({this.client});

  Dio client;

  Future<List<UserOrder>> getAllOrders(UserModel user) async {
    try {
      final response = await client.get(
        'cliente/compras?user_id=${user.id}',
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      final decodedResponse = jsonDecode(response.data);
      final list = decodedResponse['data'] as List;
      return List.generate(list.length, (i) => UserOrder.fromJson(list[i]));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
