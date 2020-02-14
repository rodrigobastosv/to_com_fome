import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';

import 'bloc.dart';

class RestaurantPickedBloc
    extends Bloc<RestaurantPickedEvent, RestaurantPickedState> {
  RestaurantPickedBloc(this.restaurantPicked, this._repository);

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
        final items =
            await _repository.getItemsRestaurant(restaurantPicked.restaurantId);
        yield ItemsLoadedState(items);
      } catch (e) {
        print(e.toString());
        yield ItemsErrorState(e.toString());
      }
    }
  }
}
