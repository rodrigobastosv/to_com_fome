import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:to_com_fome/pages/signin/signin_repository.dart';

import './bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(this.signinRepository);

  final SigninRepository signinRepository;

  @override
  SigninState get initialState => InitialSigninState();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SignUser) {
      yield LoadingSigninState();

      final user =
          await signinRepository.signInUser(event.email, event.password);
      if (user != null) {
        yield SigninSuccessState(user);
      } else {
        yield SigninFailedState();
      }
    }
  }
}
