import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/order_summary_page.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  double totalPedido;
  RestaurantPickedBloc restaurantPickedBloc;
  HomeBloc homeBloc;

  Map<String, int> order = {};

  @override
  void initState() {
    totalPedido = 0.0;
    restaurantPickedBloc = context.bloc<RestaurantPickedBloc>();
    homeBloc = context.bloc<HomeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    restaurantPickedBloc.close();
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 30,
        width: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        child: GestureDetector(
          onTap: () async {
            final finalized = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    OrderSummaryPage(totalPedido: totalPedido, order: order),
              ),
            );
            if (finalized != null && finalized) {
              setState(() {
                order = {};
                totalPedido = 0.0;
              });
              Navigator.of(context).pop();

              Flushbar(
                message: "Pedido Adicionado com Sucesso",
                icon: Icon(
                  Icons.check,
                  size: 28.0,
                  color: Colors.green,
                ),
                backgroundGradient: LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                ),
                duration: Duration(seconds: 1),
              )..show(context);
            }
          },
          child: Text(
            'Total do Pedido: R\$ ${(totalPedido).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                '$BASE_RESTAURANT_IMAGE_URL/${restaurantPickedBloc.restaurantPicked.logoRestaurante}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 12,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        restaurantPickedBloc.restaurantPicked.restaurante,
                        style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 12),
                          Text(
                            restaurantPickedBloc.restaurantPicked.stars
                                .toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Taxas',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                        Text(
                          'entrega',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '40 - 60',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                        Text(
                          'minutos',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'R\$ 10',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                        Text(
                          'mínimo',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return SimpleDialog(
                              children: <Widget>[
                                BlocBuilder(
                                  bloc: homeBloc,
                                  builder: (_, state) => Container(
                                    child: ListView.separated(
                                      itemBuilder: (_, i) => ListTile(
                                        key: ValueKey(
                                            homeBloc.paymentTypes[i].id),
                                        onTap: () {
                                          homeBloc.add(ChoosePaymentTypeEvent(
                                              homeBloc.paymentTypes[i]));
                                        },
                                        title: Text(
                                          homeBloc.paymentTypes[i].name,
                                          style: TextStyle(
                                              color: homeBloc.paymentTypes[i] ==
                                                      homeBloc
                                                          .choosedPaymentType
                                                  ? Colors.blue
                                                  : Colors.black),
                                        ),
                                      ),
                                      separatorBuilder: (_, i) => Divider(),
                                      itemCount:
                                          homeBloc.paymentTypes?.length ?? 0,
                                    ),
                                    height: 300,
                                    width: 150,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.credit_card,
                                  color: Theme.of(context).primaryColor),
                              Icon(Icons.monetization_on,
                                  color: Theme.of(context).primaryColor),
                            ],
                          ),
                          Text(
                            'pagamento',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.info_outline,
                            color: Theme.of(context).primaryColor),
                        Text(
                          'infos',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                BlocBuilder<RestaurantPickedBloc, RestaurantPickedState>(
                  builder: (_, state) {
                    if (state is ItemsLoadingState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(height: 14),
                          Text('Carregando items do cardápio'),
                        ],
                      );
                    } else if (state is ItemsLoadedState) {
                      final restaurantItems = state.items;
                      return ListView.builder(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemBuilder: (_, i) => ListTile(
                          title: Row(
                            children: <Widget>[
                              Text(restaurantItems[i].name),
                              Spacer(),
                              Text(
                                'R\$ ${restaurantItems[i].price.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '$BASE_ITEM_IMAGE_URL/${restaurantItems[i].image}'),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              final name = restaurantItems[i].name;
                              if (order.containsKey(name)) {
                                order.update(name, (_) => order[name] + 1);
                              } else {
                                order.putIfAbsent(name, () => 1);
                              }
                              Flushbar(
                                message: "Item adicionado ao Pedido",
                                icon: Icon(
                                  Icons.check,
                                  size: 28.0,
                                  color: Colors.green,
                                ),
                                backgroundGradient: LinearGradient(
                                  colors: [Colors.green, Colors.greenAccent],
                                ),
                                duration: Duration(seconds: 1),
                              )..show(context);

                              setState(() {
                                totalPedido += restaurantItems[i].price;
                              });
                            },
                          ),
                        ),
                        itemCount: restaurantItems.length,
                      );
                    } else {
                      return Container(
                        child: Center(
                          child:
                              Text('Erro ao carregar cardápio do restaurante!'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
