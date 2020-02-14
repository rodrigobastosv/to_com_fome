import 'package:meta/meta.dart';

@immutable
abstract class RestaurantPickedEvent {}

class LoadItemsEvent extends RestaurantPickedEvent {}
