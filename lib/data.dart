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

  Map<String, dynamic> toJson()=> {
    'name': name,
    'color': color.value
  };
}

class ChoiceData extends ChangeNotifier {
  final List<Choice> _choices = <Choice>[];
  ChoiceData();

  Iterable<Choice> get values => _choices;

  operator [](int index) => _choices[index];
  int get size => _choices.length;

  void add(Choice choice) {
    _choices.add(choice);
    notifyListeners();
  }

  void remove(Choice choice) {
    _choices.remove(choice);
    notifyListeners();
  }

  void set(Iterable<Choice> choices) {
    this._choices
      ..clear()
      ..addAll(choices);
    notifyListeners();
  }

  void change({@required Choice from, @required Choice to}) {
    var index = _choices.indexOf(from);
    _choices
      ..removeAt(index)
      ..insert(index, to);
  }
}
