import 'package:meta/meta.dart';
import 'package:to_com_fome/model/restaurant_item_off.dart';

@immutable
abstract class SalesState {}

class InitialSalesState extends SalesState {}

class LoadingSales extends SalesState {}

class SalesItemsLoaded extends SalesState {
  SalesItemsLoaded(this.items);

  final List<RestaurantItemOff> items;
}
