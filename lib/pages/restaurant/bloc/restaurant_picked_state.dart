import 'package:meta/meta.dart';
import 'package:to_com_fome/model/category_group.dart';

@immutable
abstract class RestaurantPickedState {}

class InitialRestaurantPickedState extends RestaurantPickedState {}

class ItemsLoadingState extends RestaurantPickedState {}

class ItemsLoadedState extends RestaurantPickedState {
  ItemsLoadedState(this.categories);

  final List<CategoryGroup> categories;
}

class ItemsErrorState extends RestaurantPickedState {
  ItemsErrorState(this.errorMessage);

  final String errorMessage;
}

class ItemAddedToOrderState extends RestaurantPickedState {
  ItemAddedToOrderState(this.items);

  final List<CategoryGroup> items;
}

class ItemRemovedFromOrderState extends RestaurantPickedState {
  ItemRemovedFromOrderState(this.items);

  final List<CategoryGroup> items;
}

class SaveOrderLoadingState extends RestaurantPickedState {}

class OrderSavedState extends RestaurantPickedState {}
