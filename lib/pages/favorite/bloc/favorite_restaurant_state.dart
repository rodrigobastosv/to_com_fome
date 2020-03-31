import 'package:equatable/equatable.dart';
import 'package:to_com_fome/model/favorite_restaurant.dart';

abstract class FavoriteRestaurantState extends Equatable {
  const FavoriteRestaurantState();
}

class InitialFavoriteRestaurantState extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}

class FetchFavoriteSuccess extends FavoriteRestaurantState {
  FetchFavoriteSuccess(this.favorites);

  final List<FavoriteRestaurant> favorites;

  @override
  List<Object> get props => [favorites];
}

class LoadingFavorites extends FavoriteRestaurantState {
  @override
  List<Object> get props => [];
}
