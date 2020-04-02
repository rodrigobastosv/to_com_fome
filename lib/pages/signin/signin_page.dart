import 'dart:async';
import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/forgot_password/forgot_password_page.dart';
import 'package:to_com_fome/pages/signin/bloc.dart';
import 'package:to_com_fome/pages/signin/signin_repository.dart';
import 'package:to_com_fome/pages/signup/bloc/bloc.dart';
import 'package:to_com_fome/pages/signup/signup_page.dart';

import '../../home.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  SigninBloc _signinBloc;
  GlobalKey<FormState> _formKey;
  String email;
  String password;
  StreamSubscription _subscription;

  @override
  void initState() {
    _signinBloc = SigninBloc(SigninRepository(DioBuilder.getDio()));
    _subscription = _signinBloc.listen((state) async {
      if (state is SigninSuccessState) {
        final user = state.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('USER', jsonEncode(user.toJson()));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                Provider<UserModel>.value(value: user, child: Home()),
          ),
        );
      }
      if (state is SigninFailedState) {
        Flushbar(
          message: "Usuário ou senha inválida",
          icon: Icon(
            Icons.warning,
            size: 28.0,
            color: Colors.yellow,
          ),
          duration: Duration(seconds: 1),
        )..show(context);
      }
    });
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double padding = 20;
    return BlocBuilder(
      bloc: _signinBloc,
      builder: (_, state) {
        if (state is InitialSigninState || state is SigninFailedState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (email) =>
                                email.isEmpty ? 'campo obrigatório' : null,
                            onSaved: (e) => email = e,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'senha',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            validator: (password) =>
                                password.isEmpty ? 'campo obrigatório' : null,
                            onSaved: (p) => password = p,
                          ),
                        ),
                        SizedBox(height: 32),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _signinBloc.add(SignUser(email, password));
                              }
                            },
                            child: Text(
                              'ENTRAR',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider<SignupBloc>(
                                    create: (_) => SignupBloc(),
                                    child: SignupPage(),
                                  ),
                                ),
                              );
                            },
                            shape: Border.all(
                                color: Theme.of(context).primaryColor),
                            child: Text(
                              'CADASTRE-SE',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text('Putz, não lembro minha senha :('),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is LoadingSigninState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
