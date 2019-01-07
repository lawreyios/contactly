import 'package:flutter/material.dart';
import 'package:introducing_flutter/HomePage.dart';
import 'LoginPage.dart';
import 'helpers/Constants.dart';

void main() => runApp(IntroFlutterApp());

class IntroFlutterApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}