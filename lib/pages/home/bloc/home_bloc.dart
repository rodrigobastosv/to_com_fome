import 'dart:async';

import 'package:bloc/bloc.dart';
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
  Cupom choosedCupom;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    print('llllll');
    if (event is LoadCategoriesEvent) {
      yield CategoriesLoadingState();

      try {
        paymentTypes = await _repository.getPaymentTypes();
        cupoms = await _repository.getCupoms();
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
    print('cupom');
    if (event is TentaAdicionarCupomEvent) {
      print('cupom2');
      final cupomCode = event.cupomCode;
      final cupomFound = cupoms.firstWhere((cupom) => cupom.code == cupomCode);

      print('a');
      if (cupomFound != null) {
        print('b');
        choosedCupom = cupomFound;
        yield CupomChoosedState(cupomFound);
      } else {
        print('c');
        yield CupomNotFoundState(cupomCode);
      }
    }
    if (event is ChooseCupomEvent) {
      choosedCupom = event.cupom;
      yield CupomChoosedState(event.cupom);
    }
  }
}
