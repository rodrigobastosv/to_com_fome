import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/pages/favorite/repository/favorite_restaurant_repository.dart';

import './bloc.dart';

class FavoriteRestaurantBloc
    extends Bloc<FavoriteRestaurantEvent, FavoriteRestaurantState> {
  FavoriteRestaurantBloc(this.repository);

  final FavoriteRestaurantRepository repository;

  @override
  FavoriteRestaurantState get initialState => InitialFavoriteRestaurantState();

  @override
  Stream<FavoriteRestaurantState> mapEventToState(
      FavoriteRestaurantEvent event) async* {
    if (event is FetchFavoriteRestaurants) {
      yield LoadingFavorites();
      final favorites =
          await repository.getFavoriteRestaurants(event.clienteId);
      favorites.sort((r1, r2) => r2.countOrders.compareTo(r1.countOrders));
      yield FetchFavoriteSuccess(favorites);
    }
  }
}
