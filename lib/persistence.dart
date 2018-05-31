import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel_of_choice/colors.dart';
import 'package:wheel_of_choice/data.dart';

class Persistence {
  static const _CHOICES_PREF_KEY = 'CHOICES';
  static List<Choice> _defaultChoices = <Choice>[
    Choice(name: 'Boulangerie', color: choiceColors[0]),
    Choice(name: 'Japonais', color: choiceColors[1]),
    Choice(name: 'Pizza', color: choiceColors[2]),
    Choice(name: 'Brasserie', color: choiceColors[3]),
  ];

  void restore(ChoiceData choiceData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(_CHOICES_PREF_KEY);
    List<Choice> choices;
    if (data != null) {
      var jsonList = (json.decode(data) as List);
      var converter = (obj) => new Choice.fromJson(obj);
      choices = jsonList.map(converter).toList();
    }
    choiceData.set(choices ?? _defaultChoices);
  }

  void save(ChoiceData choiceData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonGenerator = choiceData.values.map((c) => c.toJson());
    var jsonData = json.encode(jsonGenerator.toList());
    prefs.setString(_CHOICES_PREF_KEY, jsonData);
  }
}
