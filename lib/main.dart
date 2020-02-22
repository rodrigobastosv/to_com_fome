import 'package:flutter/material.dart';

import 'pages/signin/signin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tá na mão',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFf05925),
      ),
      home: SigninPage(),
    );
  }
}
