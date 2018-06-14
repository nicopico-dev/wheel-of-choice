import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Choice {
  final String name;
  final Color color;

  const Choice({@required this.name, this.color});

  Choice.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        color = Color(json['color']);

  Map<String, dynamic> toJson() => {'name': name, 'color': color.value};
}

class ChoiceProvider extends InheritedWidget {
  final List<Choice> choices;

  const ChoiceProvider({Key key, Widget child, this.choices = const <Choice>[]})
      : super(key: key, child: child);

  bool updateShouldNotify(ChoiceProvider oldWidget) {
    return !listEquals(choices, oldWidget.choices);
  }

  static List<Choice> of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ChoiceProvider)
            as ChoiceProvider)
        .choices;
  }
}
