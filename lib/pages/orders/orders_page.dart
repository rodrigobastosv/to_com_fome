import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_com_fome/model/user_order.dart';
import 'package:to_com_fome/pages/orders/bloc/bloc.dart';

class OrdersPage extends StatelessWidget {
  final df1 = DateFormat('yyyy-mm-dd hh:mm:ss');
  final df2 = DateFormat('dd-mm-yyyy hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (_, state) {
        if (state is FetchOrdersSuccess) {
          if (state.orders.isEmpty) {
            return Center(
              child: Text('Nenhuma compra realizada!'),
            );
          }
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state.orders[i].restaurantName,
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${df2.format(df1.parse(state.orders[i].createdAt))}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView(
                        children: _getOrderItems(state.orders[i].items),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total: ',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            'R\$ ${state.orders[i].totalFinal}',
                            style: TextStyle(fontSize: 22),
                          ),
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
            itemCount: state.orders.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<Widget> _getOrderItems(List<UserOrderItems> items) {
    return items
        .map(
          (orderItem) => ListTile(
            title: Text(orderItem.name),
            trailing: Text(
              'R\$ ${double.parse(orderItem.price).toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
        .toList();
  }
}
