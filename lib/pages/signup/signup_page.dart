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
  String district;
  String mobile;
  String state;
  String city;

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
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'bairro',
                        prefixIcon: Icon(Icons.add_location),
                      ),
                      validator: (bairro) =>
                          bairro.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (bairro) => district = bairro,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'celular',
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                      validator: (celular) =>
                          celular.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (celular) => mobile = celular,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'estado',
                        prefixIcon: Icon(Icons.map),
                      ),
                      validator: (estado) =>
                          estado.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (estado) => state = estado,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'cidade',
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      validator: (cidade) =>
                          cidade.isEmpty ? 'campo obrigatório' : null,
                      onSaved: (cidade) => city = cidade,
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          signupBloc.add(
                            SignupUser(
                              name: name,
                              email: email,
                              password: password,
                              adress: adress,
                              district: district,
                              mobile: mobile,
                              state: state,
                              city: city,
                            ),
                          );
                        }
                      },
                      child: BlocBuilder(
                        bloc: signupBloc,
                        builder: (_, state) {
                          if (state is InitialSignupState) {
                            return Text(
                              'CADASTRAR',
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
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
