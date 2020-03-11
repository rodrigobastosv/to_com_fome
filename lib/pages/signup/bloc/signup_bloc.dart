import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/pages/signup/signup_repository.dart';

import 'bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupRepository _signupRepository =
      SignupRepository(client: DioBuilder.getDio());

  @override
  SignupState get initialState => InitialSignupState();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupUser) {
      yield LoadingSignupState();

      try {
        await _signupRepository.signUpUser(
          name: event.name,
          email: event.email,
          password: event.password,
          adress: event.adress,
        );
        yield SignupSuccessState();
      } on Exception {
        yield SignupFailedState();
      }
    }
  }
}
