import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wheel_of_choice/colors.dart';

class Choice {
  final String name;
  final Color color;

  Choice({@required this.name, this.color});
}

class ChoiceData extends ChangeNotifier {
  final List<Choice> _choices = <Choice>[
    Choice(name: 'Boulangerie', color: choiceColors[0]),
    Choice(name: 'Japonais', color: choiceColors[1]),
    Choice(name: 'Pizza', color: choiceColors[2]),
    Choice(name: 'Brasserie', color: choiceColors[3]),
  ];
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

  void change({@required Choice from, @required Choice to}) {
    var index = _choices.indexOf(from);
    _choices
      ..removeAt(index)
      ..insert(index, to);
  }
}
