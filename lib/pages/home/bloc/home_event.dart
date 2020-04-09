import 'package:meta/meta.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/payment_type_model.dart';
import 'package:to_com_fome/model/user_model.dart';

@immutable
abstract class HomeEvent {}

class LoadCategoriesEvent extends HomeEvent {
  LoadCategoriesEvent(this.user);

  final UserModel user;
}

class LoadBannersEvent extends HomeEvent {}

class ChoosePaymentTypeEvent extends HomeEvent {
  ChoosePaymentTypeEvent(this.paymentType);

  final PaymentType paymentType;
}

class TentaAdicionarCupomEvent extends HomeEvent {
  TentaAdicionarCupomEvent(this.cupomCode);

  final String cupomCode;
}

class ChooseCupomEvent extends HomeEvent {
  ChooseCupomEvent(this.cupom);

  final Cupom cupom;
}

class Teste extends HomeEvent {}
