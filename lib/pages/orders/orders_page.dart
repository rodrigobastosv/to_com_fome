import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:to_com_fome/model/order_item.dart';

import 'mock_orders_page.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => AnimatedCard(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Restaurante: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      orders[i].restaurantName,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Data: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      orders[i].orderDate,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: ListView(
                  children: _getOrderItems(orders[i].items),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total: ', style: TextStyle(fontSize: 22),),
                    Text('R\$ ${orders[i].totalValue.toStringAsFixed(2)}', style: TextStyle(fontSize: 22),),
                  ],
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
      separatorBuilder: (_, i) => Divider(),
      itemCount: orders.length,
    );
  }

  List<Widget> _getOrderItems(List<OrderItem> items) {
    return items
        .map(
          (orderItem) => ListTile(
            title: Text(orderItem.name),
            trailing: Text('R\$ ${orderItem.value.toStringAsFixed(2)}', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
        )
        .toList();
  }
}
