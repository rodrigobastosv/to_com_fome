import 'package:meta/meta.dart';

@immutable
abstract class SigninEvent {}

class SignUser extends SigninEvent {
  SignUser(this.email, this.password);

  final String email;
  final String password;
}
