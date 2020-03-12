import 'package:meta/meta.dart';

@immutable
abstract class SignupEvent {}

class SignupUser extends SignupEvent {
  SignupUser({
    this.name,
    this.email,
    this.password,
    this.adress,
    this.mobile,
    this.district,
    this.state,
    this.city,
  });

  final String name;
  final String email;
  final String password;
  final String adress;
  final String mobile;
  final String district;
  final String state;
  final String city;
}
