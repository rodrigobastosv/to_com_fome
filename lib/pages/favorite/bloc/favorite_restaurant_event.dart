import 'package:equatable/equatable.dart';

abstract class FavoriteRestaurantEvent extends Equatable {
  const FavoriteRestaurantEvent();
}

class FetchFavoriteRestaurants extends FavoriteRestaurantEvent {
  FetchFavoriteRestaurants(this.clienteId);

  final String clienteId;

  @override
  List<Object> get props => [clienteId];
}
