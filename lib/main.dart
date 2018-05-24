import 'package:flutter/material.dart';
import 'package:wheel_of_choice/choice_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheel of Choice',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amberAccent,
          accentColorBrightness: Brightness.dark),
      home: ChoiceEditionPage(),
    );
  }
}