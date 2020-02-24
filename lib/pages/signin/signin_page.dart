import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../home.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    double padding = 20;
    return Scaffold(
      body: Container(
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );
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
                onPressed: () {},
                shape: Border.all(color: Theme.of(context).primaryColor),
                child: Text(
                  'CADASTRE-SE',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: MaterialButton(
                onPressed: () {},
                shape: Border.all(color: Color.fromRGBO(65, 103, 178, 1)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      AntDesign.facebook_square,
                      color: Color.fromRGBO(65, 103, 178, 1),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'CONTINUAR COM FACEBOOK',
                      style: TextStyle(
                        color: Color.fromRGBO(65, 103, 178, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: FlatButton(
                onPressed: () {},
                child: Text('Putz, não lembro minha senha :('),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
