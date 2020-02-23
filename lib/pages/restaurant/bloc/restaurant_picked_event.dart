import 'package:meta/meta.dart';
import 'package:to_com_fome/model/order_item.dart';
import 'package:to_com_fome/model/restaurant_item.dart';

@immutable
abstract class RestaurantPickedEvent {}

class LoadItemsEvent extends RestaurantPickedEvent {}

class ItemPicked extends RestaurantPickedEvent {
  ItemPicked(this.orderItem);

  final OrderItem orderItem;
}

class ItemAddedToOrder extends RestaurantPickedEvent {
  ItemAddedToOrder(this.item, this.qtd);

  final RestaurantItem item;
  final int qtd;
}

class ChangedItemQuantity extends RestaurantPickedEvent {
  ChangedItemQuantity(this.orderItem, this.qtd);

  final OrderItem orderItem;
  final int qtd;
}
