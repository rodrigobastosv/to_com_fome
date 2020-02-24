import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/restaurant_item.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/item_picked_page.dart';
import 'package:to_com_fome/pages/restaurant/order_summary_page.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  RestaurantPickedBloc restaurantPickedBloc;
  HomeBloc homeBloc;

  @override
  void initState() {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 30,
        margin: EdgeInsets.only(left: 40),
        width: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        child: GestureDetector(
          onTap: () async {
            final finalized = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: restaurantPickedBloc,
                  child: OrderSummaryPage(),
                ),
              ),
            );
            if (finalized != null && finalized) {
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
          child: BlocBuilder<RestaurantPickedBloc, RestaurantPickedState>(
            bloc: restaurantPickedBloc,
            builder: (_, state) {
              return Text(
                'Ver Pedido: R\$ ${(restaurantPickedBloc.order.totalValue).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              );
            },
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
                BlocListener<RestaurantPickedBloc, RestaurantPickedState>(
                  listener: (_, state) {
                    if (state is ItemAddedToOrderState) {
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
                    }
                  },
                  child:
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
                        return _getRestaurantItemsList(restaurantItems);
                      } else if (state is ItemAddedToOrderState) {
                        final restaurantItems = state.items;
                        return _getRestaurantItemsList(restaurantItems);
                      } else {
                        return Container(
                          child: Center(
                            child: Text(
                                'Erro ao carregar cardápio do restaurante!'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRestaurantItemsList(List<RestaurantItem> items) {
    return ListView.builder(
      controller: ScrollController(),
      shrinkWrap: true,
      itemBuilder: (_, i) => ListTile(
        onTap: () {
          Navigator.of(context).push((MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                  value: restaurantPickedBloc,
                  child: ItemPickedPage(items[i])))));
        },
        title: Row(
          children: <Widget>[
            Text(items[i].name),
            Spacer(),
            Text(
              'R\$ ${items[i].price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        leading: Hero(
          tag: '${items[i].name}',
          child: CircleAvatar(
            backgroundImage:
                NetworkImage('$BASE_ITEM_IMAGE_URL/${items[i].image}'),
          ),
        ),
      ),
      itemCount: items.length,
    );
  }
}
