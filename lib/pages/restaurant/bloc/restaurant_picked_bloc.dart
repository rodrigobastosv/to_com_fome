import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/category_group.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/order_item.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/model/restaurant_item.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';

import 'bloc.dart';

class RestaurantPickedBloc
    extends Bloc<RestaurantPickedEvent, RestaurantPickedState> {
  RestaurantPickedBloc(
      this.restaurantPicked, UserModel client, this._repository) {
    order = Order(items: [], client: client);
  }

  Order order;
  List<CategoryGroup> categoriesOnMenu;
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
        categoriesOnMenu =
            await _repository.getItemsRestaurant(restaurantPicked.slug);
        yield ItemsLoadedState(categoriesOnMenu);
      } catch (e) {
        print(e.toString());
        yield ItemsErrorState(e.toString());
      }
    }
    if (event is ItemAddedToOrder) {
      final restaurantItem = event.item;
      final qtdPicked = event.qtd;
      final orderItem = OrderItem(
        id: restaurantItem.id,
        categoryId: restaurantItem.categoryId,
        name: restaurantItem.name,
        type: restaurantItem.type,
        qtd: qtdPicked,
        value: restaurantItem.price,
        obs: event.obs,
      );
      order.items.add(orderItem);
      yield ItemAddedToOrderState(categoriesOnMenu);
    }
    if (event is RemoveItemFromOrder) {
      order.items.remove(event.orderItem);
      yield ItemRemovedFromOrderState(categoriesOnMenu);
    }
    if (event is DigitaCEP) {}
    if (event is SaveOrder) {
      yield SaveOrderLoadingState();
      await _repository.saveOrder(
        order: order,
        address: event.address,
        district: event.district,
        mobile: event.mobile,
        paymentType: event.paymentType,
      );
      yield OrderSavedState();
    }
  }
}
