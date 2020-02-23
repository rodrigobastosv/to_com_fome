import 'package:meta/meta.dart';
import 'package:to_com_fome/model/restaurant_item.dart';

@immutable
abstract class RestaurantPickedState {}

class InitialRestaurantPickedState extends RestaurantPickedState {}

class ItemsLoadingState extends RestaurantPickedState {}

class ItemsLoadedState extends RestaurantPickedState {
  ItemsLoadedState(this.items);

  final List<RestaurantItem> items;
}

class ItemsErrorState extends RestaurantPickedState {
  ItemsErrorState(this.errorMessage);

  final String errorMessage;
}

class ItemAddedToOrderState extends RestaurantPickedState {
  ItemAddedToOrderState(this.items);

  final List<RestaurantItem> items;
}
