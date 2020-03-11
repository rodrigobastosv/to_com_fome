import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_com_fome/pages/signin/signin_page.dart';
import 'package:to_com_fome/pages/signup/bloc/bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formKey;
  String name;
  String email;
  String password;
  String adress;

  SignupBloc signupBloc;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    signupBloc = BlocProvider.of<SignupBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double padding = 20;
    return Scaffold(
      body: BlocListener(
        bloc: signupBloc,
        listener: (_, state) {
          if (state is SignupSuccessState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SigninPage()));
          }
          if (state is SignupFailedState) {
            print('falha');
          }
        },
        child: Container(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 48, 18, 18),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'nome',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (nome) =>
                          nome.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (nome) => name = nome,
                    ),
                  ),
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
                      validator: (senha) =>
                          senha.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (senha) => password = senha,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'endereço',
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: (endereco) =>
                          endereco.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (endereco) => adress = endereco,
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          signupBloc.add(
                            SignupUser(
                              name: name,
                              email: email,
                              password: password,
                              adress: adress,
                            ),
                          );
                        }
                        /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => Home(),
                          ),
                        );*/
                      },
                      child: Text(
                        'CADASTRAR',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
