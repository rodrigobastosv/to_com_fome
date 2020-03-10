import 'package:meta/meta.dart';

@immutable
abstract class SalesEvent {}

class LoadItems extends SalesEvent {}
