import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email;
  GlobalKey<FormState> key;

  @override
  void initState() {
    key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar senha'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Form(
            key: key,
            child: ListView(
              children: <Widget>[
                Image.asset('assets/images/forgot.png'),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'E-mail',
                    ),
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'email é obrigatório';
                      }
                      if (!EmailValidator.validate(email)) {
                        return 'email é inválido';
                      }
                      return null;
                    },
                    onChanged: (e) => email = e,
                  ),
                ),
                SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: RaisedButton.icon(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      final form = key.currentState;
                      if (form.validate()) {
                        print(email);
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                    label: Text(
                      'Enviar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
