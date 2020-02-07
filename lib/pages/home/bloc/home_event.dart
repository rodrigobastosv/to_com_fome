import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class LoadCategoriesEvent extends HomeEvent {}
