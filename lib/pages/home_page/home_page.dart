import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/pages/home_page/mock_home_page.dart';
import 'package:to_com_fome/pages/restaurant_page/restaurant_page.dart';

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
                Text(
                  foodSections[i].name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => Hero(
                        tag: restaurants[i].id.toString(),
                        child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        RestaurantPage(restaurants[i]))),
                            child: RestaurantWidget(restaurants[i]))),
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
            child: Container(
              height: 100,
              width: 200,
              child: Image.network(
                restaurant.assetImage,
                fit: BoxFit.cover,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          Text(
            restaurant.name,
            style: TextStyle(color: mainColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
