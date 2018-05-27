import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Choice {
  final String name;
  final Color color;

  Choice({@required this.name, this.color});
}

class ChoiceData extends ChangeNotifier {
  final List<Choice> _choices = <Choice>[
    Choice(name: 'Boulangerie', color: Colors.brown),
    Choice(name: 'Japonais', color: Colors.indigo),
    Choice(name: 'Pizza', color: Colors.red),
    Choice(name: 'Brasserie', color: Colors.yellow),
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
