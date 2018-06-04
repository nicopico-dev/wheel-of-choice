import 'package:flutter/material.dart';
import 'package:wheel_of_choice/components/choice_wheel.dart';
import 'package:wheel_of_choice/components/refresh_on_change.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: RefreshOnChange(
            builder: (context) => ChoiceWheel(choices: choices),
            changeNotifier: choices,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          /* TODO */
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _handleEdit(BuildContext context) {
    Navigator.of(context).pushNamed("/settings");
  }
}
