import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data/choice.dart';
import 'package:wheel_of_choice/data/persistence.dart';
import 'package:wheel_of_choice/screens/home.dart';
import 'package:wheel_of_choice/screens/settings.dart';

void main() => runApp(WheelOfChoiceApp());

class WheelOfChoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Choice>>(
      future: Persistence().load(),
      builder: (context, snap) => ChoiceProvider(
            choices: snap.data ?? <Choice>[],
            child: MaterialApp(
              title: 'Wheel of Choice',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                accentColor: Colors.blue,
                accentColorBrightness: Brightness.dark,
              ),
              routes: <String, WidgetBuilder>{
                '/': (context) => Home(),
                '/settings': (context) => Settings()
              },
            ),
          ),
    );
  }
}
