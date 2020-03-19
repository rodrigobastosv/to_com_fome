import 'package:meta/meta.dart';
import 'package:to_com_fome/model/banner.dart';
import 'package:to_com_fome/model/category_restaurant.dart';
import 'package:to_com_fome/model/cupom.dart';
import 'package:to_com_fome/model/payment_type_model.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class CategoriesLoadingState extends HomeState {}

class PaymentTypeChoosedState extends HomeState {
  PaymentTypeChoosedState(this.paymentType);

  final PaymentType paymentType;
}

class CupomChoosedState extends HomeState {
  CupomChoosedState(this.cupom);

  final Cupom cupom;
}

class CupomNotFoundState extends HomeState {
  CupomNotFoundState(this.cupomCode);

  final String cupomCode;
}

class CategoriesLoadedState extends HomeState {
  CategoriesLoadedState(this.categories, this.paymentTypes, this.banners);

  final List<CategoryRestaurant> categories;
  final List<PaymentType> paymentTypes;
  final List<Banner> banners;
}

class CategoriesErrorOnLoadState extends HomeState {
  CategoriesErrorOnLoadState(this.errorMessage);

  final String errorMessage;
}
