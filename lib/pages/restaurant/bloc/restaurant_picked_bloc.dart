import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/order_item.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/model/restaurant_item.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';

import 'bloc.dart';

class RestaurantPickedBloc
    extends Bloc<RestaurantPickedEvent, RestaurantPickedState> {
  RestaurantPickedBloc(this.restaurantPicked, this._repository) {
    order = Order(items: []);
  }

  Order order;
  List<RestaurantItem> itemsOnMenu;
  final Restaurant restaurantPicked;
  final RestaurantPickedRepository _repository;

  @override
  RestaurantPickedState get initialState => InitialRestaurantPickedState();

  @override
  Stream<RestaurantPickedState> mapEventToState(
      RestaurantPickedEvent event) async* {
    if (event is LoadItemsEvent) {
      yield ItemsLoadingState();

      try {
        itemsOnMenu =
            await _repository.getItemsRestaurant(restaurantPicked.slug);
        print(itemsOnMenu);
        yield ItemsLoadedState(itemsOnMenu);
      } catch (e) {
        print(e.toString());
        yield ItemsErrorState(e.toString());
      }
    }
    if (event is ItemAddedToOrder) {
      final restaurantItem = event.item;
      final qtdPicked = event.qtd;
      final orderItem = OrderItem(
        name: restaurantItem.name,
        qtd: qtdPicked,
        value: restaurantItem.price,
      );
      order.items.add(orderItem);
      yield ItemAddedToOrderState(itemsOnMenu);
    }
  }
}
