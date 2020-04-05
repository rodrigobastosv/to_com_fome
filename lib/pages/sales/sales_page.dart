import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/item_picked_page.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';

import 'bloc/sales_bloc.dart';
import 'bloc/sales_state.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesBloc, SalesState>(
      builder: (_, state) {
        if (state is LoadingSales || state is InitialSalesState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final items = (state as SalesItemsLoaded).items;
          return ListView.builder(
            itemBuilder: (_, i) {
              final val = items[i].restaurantItem.price -
                  double.parse(items[i].priceOff);
              final percent = val / items[i].restaurantItem.price;
              final discount = percent * 100;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<RestaurantPickedBloc>(
                            create: (_) => RestaurantPickedBloc(
                              items[i].restaurant,
                              Provider.of<UserModel>(context, listen: false),
                              RestaurantPickedRepository(
                                  client: DioBuilder.getDio()),
                            ),
                          ),
                          BlocProvider.value(value: context.bloc<HomeBloc>()),
                        ],
                        child: Provider.value(
                          value: Provider.of<UserModel>(context, listen: false),
                          child: ItemPickedPage(
                              items[i].restaurantItem.copyWith(
                                    valueWithDiscount:
                                        double.parse(items[i].priceOff),
                                  ),
                              fromSales: true),
                        ),
                      ),
                    ),
                  );
                },
                child: AnimatedCard(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.network(
                                  '$BASE_RESTAURANT_IMAGE_URL/${items[i].restaurant.logoPath}/${items[i].restaurant.logo}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: Text(
                                  items[i].restaurantItem.description,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Image.network(
                              '$BASE_RESTAURANT_IMAGE_URL/${items[i].restaurantItem.imagePath}/${items[i].restaurantItem.image}',
                              fit: BoxFit.fill,
                              height: 130,
                            ),
                            Positioned(
                              left: 10,
                              child: Chip(
                                backgroundColor: Colors.redAccent,
                                label: Text(
                                  '${discount.toStringAsFixed(0)}% OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Preço: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'De R\$ ${items[i].restaurantItem.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'por R\$ ${double.parse(items[i].priceOff).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
              );
            },
            itemCount: items.length,
          );
        }
      },
    );
  }
}
