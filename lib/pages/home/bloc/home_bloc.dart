import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/banner.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/pages/home/repository/home_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository);

  HomeRepository _repository;

  List<PaymentType> paymentTypes;
  PaymentType choosedPaymentType;
  List<Cupom> cupoms;
  List<Banner> banners;
  Cupom choosedCupom;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadCategoriesEvent) {
      yield CategoriesLoadingState();

      try {
        paymentTypes = await _repository.getPaymentTypes();
        cupoms = await _repository.getCupoms();
        banners = await _repository.getBanners();
        final categories = await _repository.getCategoryRestaurant();
        yield CategoriesLoadedState(categories, paymentTypes, banners);
      } catch (e) {
        yield CategoriesErrorOnLoadState(e.toString());
      }
    }
    if (event is ChoosePaymentTypeEvent) {
      choosedPaymentType = event.paymentType;
      yield PaymentTypeChoosedState(event.paymentType);
    }
    if (event is TentaAdicionarCupomEvent) {
      final cupomCode = event.cupomCode;
      int cupomIndex = cupoms.indexWhere((cupom) => cupom.code == cupomCode);
      if (cupomIndex != -1) {
        choosedCupom = cupoms[cupomIndex];
        yield CupomChoosedState(cupoms[cupomIndex]);
      } else {
        yield CupomNotFoundState(cupomCode);
      }
    }
    if (event is ChooseCupomEvent) {
      choosedCupom = event.cupom;
      yield CupomChoosedState(event.cupom);
    }
  }
}
