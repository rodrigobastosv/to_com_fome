import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';
import 'package:to_com_fome/model/user_model.dart';

import 'home.dart';
import 'pages/signin/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesMonitor.init();
  SharedPreferencesMonitor.setKey(GlobalKey<NavigatorState>());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString('USER');
  final user =
      userString != null ? UserModel.fromJson(jsonDecode(userString)) : null;
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  MyApp(this.user);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tá na mão',
      debugShowCheckedModeBanner: false,
      navigatorKey: SharedPreferencesMonitor.getKey(),
      theme: ThemeData(
        primaryColor: Color(0xFFf05925),
        fontFamily: 'CenturyGothic',
      ),
      home: LoaderOverlay(
        useDefaultLoading: true,
        child: user != null
            ? Provider<UserModel>.value(value: user, child: Home())
            : SigninPage(),
      ),
    );
  }
}
