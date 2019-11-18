import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tá na mão',
      theme: ThemeData(
        primaryColor: Color(0xFFf05925),
      ),
      home: Home(),
    );
  }
}