import 'package:flutter/material.dart';
import 'package:wheel_of_choice/components/choice_wheel.dart';
import 'package:wheel_of_choice/data.dart';

class Home extends StatelessWidget {
  const Home(this.choices);

  final ChoiceData choices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel of Choice'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _handleEdit(context),
          )
        ],
      ),
      body: ChoiceWheel(choices: choices),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          /* TODO */
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _handleEdit(BuildContext context) {
    Navigator.of(context).pushNamed("/settings");
  }
}
