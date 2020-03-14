import 'package:meta/meta.dart';
import 'package:to_com_fome/model/user_model.dart';

@immutable
abstract class SigninState {}

class InitialSigninState extends SigninState {}

class LoadingSigninState extends SigninState {}

class SigninSuccessState extends SigninState {
  SigninSuccessState(this.user);

  final UserModel user;
}

class SigninFailedState extends SigninState {}
