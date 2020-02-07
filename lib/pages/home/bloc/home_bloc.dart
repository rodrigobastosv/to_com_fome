import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/pages/home/repository/home_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository);

  HomeRepository _repository;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadCategoriesEvent) {
      yield CategoriesLoadingState();

      try {
        final categories = await _repository.getCategoryRestaurant();
        yield CategoriesLoadedState(categories);
      } catch (e) {
        yield CategoriesErrorOnLoadState(e.toString());
      }
    }
  }
}
