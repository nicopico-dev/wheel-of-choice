import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';
import 'package:wheel_of_choice/persistence.dart';
import 'package:wheel_of_choice/screens/home.dart';
import 'package:wheel_of_choice/screens/settings.dart';

void main() => runApp(WheelOfChoiceApp());

class WheelOfChoiceApp extends StatelessWidget {
  final ChoiceData choices = ChoiceData();

  WheelOfChoiceApp() {
    Persistence().restore(choices);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheel of Choice',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amberAccent,
          accentColorBrightness: Brightness.dark),
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(choices),
        '/settings': (context) => Settings(choices)
      },
    );
  }
}
