import 'package:equatable/equatable.dart';
import 'package:to_com_fome/model/user_order.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class InitialOrdersState extends OrdersState {
  @override
  List<Object> get props => [];
}

class FetchOrdersSuccess extends OrdersState {
  FetchOrdersSuccess(this.orders);

  final List<UserOrder> orders;

  @override
  List<Object> get props => [orders];
}

class LoadingOrders extends OrdersState {
  @override
  List<Object> get props => [];
}
