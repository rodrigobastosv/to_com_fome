import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/model/restaurant_item_off.dart';
import 'package:to_com_fome/pages/sales/repository/sales_repository.dart';

import 'bloc.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  SalesBloc(this._repository);

  SalesRepository _repository;

  List<RestaurantItemOff> itemsOnSale;

  @override
  SalesState get initialState => InitialSalesState();

  @override
  Stream<SalesState> mapEventToState(SalesEvent event) async* {
    if (event is LoadItems) {
      yield LoadingSales();
      itemsOnSale = await _repository.getItemsOnSale();
      yield SalesItemsLoaded(itemsOnSale);
    }
  }
}
