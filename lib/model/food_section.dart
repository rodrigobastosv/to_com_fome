import 'restaurant.dart';

class FoodSection {
  FoodSection({this.name, this.assetImage, this.restaurants});

  final String name;
  final String assetImage;
  final List<Restaurant> restaurants;
}