import 'package:meta/meta.dart';
import 'package:to_com_fome/model/order_item.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/model/restaurant_item.dart';

@immutable
abstract class RestaurantPickedEvent {}

class LoadItemsEvent extends RestaurantPickedEvent {}

class ItemPicked extends RestaurantPickedEvent {
  ItemPicked(this.orderItem);

  final OrderItem orderItem;
}

class ItemAddedToOrder extends RestaurantPickedEvent {
  ItemAddedToOrder(this.item, this.qtd, this.obs);

  final RestaurantItem item;
  final int qtd;
  final String obs;
}

class ChangedItemQuantity extends RestaurantPickedEvent {
  ChangedItemQuantity(this.orderItem, this.qtd);

  final OrderItem orderItem;
  final int qtd;
}

class SaveOrder extends RestaurantPickedEvent {
  SaveOrder({this.address, this.district, this.mobile, this.paymentType});

  final String address;
  final String district;
  final String mobile;
  final PaymentType paymentType;
}

class TransientState extends RestaurantPickedEvent {}
