import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';

class ChoiceWheel extends StatelessWidget {
  const ChoiceWheel({this.choices});

  final ChoiceData choices;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: choices.size,
        itemBuilder: (context, index) => _createSection(choices[index]),
      );

  _createSection(Choice choice) {
    return Container(
      child: ListTile(title: Text(choice.name)),
      color: choice.color,
    );
  }
}
