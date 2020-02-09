import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/restaurant_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state is CategoriesLoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is CategoriesLoadedState) {
          final categories = state.categories;
          return ListView.builder(
            itemBuilder: (_, i) {
              final category = categories[i];
              final restaurants = category.restaurants;
              return AnimatedCard(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        category.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 160,
                        child: restaurants.isEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 12),
                                  Center(
                                    child: Text(
                                        'Nenhum restaurante nesta categoria!'),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, i) => Hero(
                                    tag: restaurants[i].restaurantId.toString(),
                                    child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => RestaurantPage(
                                                    restaurants[i]))),
                                        child:
                                            RestaurantWidget(restaurants[i]))),
                                itemCount: restaurants.length,
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: categories.length,
          );
        } else if (state is CategoriesErrorOnLoadState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  RestaurantWidget(this.restaurant);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    return Container(
      width: 260,
      child: Column(
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 100,
              width: 200,
              child: Image.network(
                '$BASE_RESTAURANT_IMAGE_URL/${restaurant.logoRestaurante}',
                fit: BoxFit.cover,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          Expanded(
            child: Text(
              restaurant.restaurante,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: mainColor, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
