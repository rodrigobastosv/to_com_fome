import 'package:meta/meta.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/payment_type_model.dart';

@immutable
abstract class HomeEvent {}

class LoadCategoriesEvent extends HomeEvent {}

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
