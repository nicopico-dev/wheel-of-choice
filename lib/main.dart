import 'package:flutter/material.dart';
import 'package:wheel_of_choice/home.dart';
import 'package:wheel_of_choice/data.dart';
import 'package:wheel_of_choice/settings.dart';

void main() => runApp(WheelOfChoiceApp());

class WheelOfChoiceApp extends StatefulWidget {
  @override
  WheelOfChoiceAppState createState() => WheelOfChoiceAppState();
}

class WheelOfChoiceAppState extends State<WheelOfChoiceApp> {
  ChoiceData choices;

  @override
  void initState() {
    super.initState();
    choices = ChoiceData();
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
