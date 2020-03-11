import 'package:meta/meta.dart';

@immutable
abstract class SignupState {}

class InitialSignupState extends SignupState {}

class LoadingSignupState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailedState extends SignupState {}
