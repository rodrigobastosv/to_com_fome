import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/pages/home/repository/home_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository);

  HomeRepository _repository;

  List<PaymentType> paymentTypes;
  PaymentType choosedPaymentType;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadCategoriesEvent) {
      yield CategoriesLoadingState();

      try {
        paymentTypes = await _repository.getPaymentTypes();
        final categories = await _repository.getCategoryRestaurant();
        yield CategoriesLoadedState(categories, paymentTypes);
      } catch (e) {
        yield CategoriesErrorOnLoadState(e.toString());
      }
    }
    if (event is ChoosePaymentTypeEvent) {
      choosedPaymentType = event.paymentType;
      yield PaymentTypeChoosedState(event.paymentType);
    }
  }
}
