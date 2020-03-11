import 'package:meta/meta.dart';

@immutable
abstract class SignupEvent {}

class SignupUser extends SignupEvent {
  SignupUser({
    this.name,
    this.email,
    this.password,
    this.adress,
  });

  final String name;
  final String email;
  final String password;
  final String adress;
}
