import 'package:meta/meta.dart';
import 'package:to_com_fome/model/payment_type_model.dart';

@immutable
abstract class HomeEvent {}

class LoadCategoriesEvent extends HomeEvent {}

class ChoosePaymentTypeEvent extends HomeEvent {
  ChoosePaymentTypeEvent(this.paymentType);

  final PaymentType paymentType;
}
