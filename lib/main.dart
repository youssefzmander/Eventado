import 'package:flutter/material.dart';
import 'singin.out/welcome_page.dart';

const color = const Color(0xFF6666ff);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventado',
      home: WelcomePage(),
    );
  }
}
