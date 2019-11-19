import 'order_item.dart';

class Order {
  Order({this.restaurantName, this.orderDate, this.totalValue, this.items});

  final String restaurantName;
  final String orderDate;
  final double totalValue;
  final List<OrderItem> items;
}