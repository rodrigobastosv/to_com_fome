import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:to_com_fome/pages/home_page/mock_home_page.dart';
import 'package:to_com_fome/mock_data/restaurant.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        final restaurants = foodSections[i].restaurants;
        return AnimatedCard(
          child: Card(
            child: Column(
              children: <Widget>[
                Text(foodSections[i].name, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                Container(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => RestaurantWidget(restaurants[i]),
                    itemCount: restaurants.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: foodSections.length,
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
            child: Image.network(
              restaurant.assetImage,
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          Text(restaurant.name, style: TextStyle(color: mainColor),),
        ],
      ),
    );
  }
}
