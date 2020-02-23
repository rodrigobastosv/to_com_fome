import 'package:to_com_fome/model/order2.dart';
import 'package:to_com_fome/model/order_item.dart';

final orders = [
  Order2(
      restaurantName: 'McDonald\'s',
      totalValue: 33.25,
      orderDate: '13/11/2019 11:23:12',
      items: [
        OrderItem(name: 'Hamburguer', value: 20.25),
        OrderItem(name: 'Refri', value: 13.00),
      ]),
  Order2(
      restaurantName: 'Bob\'s',
      totalValue: 11.00,
      orderDate: '10/11/2019 20:31:14',
      items: [
        OrderItem(name: 'Milkshake de Chocolate', value: 11.00),
      ]),
  Order2(
      restaurantName: 'San Paolo',
      totalValue: 33.99,
      orderDate: '0711/2019 22:11:44',
      items: [
        OrderItem(name: 'Semplice Simples', value: 13.99),
        OrderItem(name: 'Semplice Duplo', value: 20.00),
      ]),
  Order2(
      restaurantName: 'Pizza Hut',
      totalValue: 58.14,
      orderDate: '13/11/2019 11:23:12',
      items: [
        OrderItem(name: 'Pizza Pan Brasileira', value: 53.14),
        OrderItem(name: 'Refrigerante de Cola', value: 5.00),
      ]),
];
