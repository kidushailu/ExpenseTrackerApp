import 'package:flutter/material.dart';
import 'splash_screen.dart';
//testing

void main() {
  runApp(SpendWellApp());
}


class SpendWellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'SpendWell',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}
