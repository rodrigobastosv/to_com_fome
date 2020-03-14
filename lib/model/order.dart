import 'package:to_com_fome/model/user_model.dart';

import 'order_item.dart';

class Order {
  Order({this.restaurantName, this.orderDate, this.items, this.client});

  final String restaurantName;
  final String orderDate;
  final List<OrderItem> items;
  final UserModel client;

  double get totalValue {
    double total = 0.0;
    for (OrderItem item in items) {
      total += item.value * item.qtd;
    }
    return total;
  }

  bool hasItem(OrderItem item) {
    return items.contains(item);
  }
}
