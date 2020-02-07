import 'package:meta/meta.dart';
import 'package:to_com_fome/model/category_restaurant.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class CategoriesLoadingState extends HomeState {}

class CategoriesLoadedState extends HomeState {
  CategoriesLoadedState(this.categories);

  final List<CategoryRestaurant> categories;
}

class CategoriesErrorOnLoadState extends HomeState {
  CategoriesErrorOnLoadState(this.errorMessage);

  final String errorMessage;
}
