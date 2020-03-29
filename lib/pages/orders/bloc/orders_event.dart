import 'package:equatable/equatable.dart';

import '../../../model/user_model.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class FetchOrders extends OrdersEvent {
  FetchOrders(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}
