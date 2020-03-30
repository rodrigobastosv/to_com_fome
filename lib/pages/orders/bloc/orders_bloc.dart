import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/pages/orders/repository/orders_repository.dart';

import './bloc.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({this.repository});

  final OrdersRepository repository;

  @override
  OrdersState get initialState => InitialOrdersState();

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is FetchOrders) {
      yield LoadingOrders();
      print(event.user);
      try {
        final orders = await repository.getAllOrders(event.user);
        yield FetchOrdersSuccess(orders ?? []);
      } on Exception {}
    }
  }
}
