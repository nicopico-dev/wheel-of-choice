import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wheel_of_choice/choice_color_swatch.dart';
import 'package:wheel_of_choice/choice_editor.dart';
import 'package:wheel_of_choice/data.dart';

class Settings extends StatefulWidget {
  const Settings(this.choices);

  final ChoiceData choices;

  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _newChoiceTextController = TextEditingController();
  ChoiceData _choices;

  @override
  void initState() {
    super.initState();
    _choices = widget.choices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(children: <Widget>[
        Flexible(
          child: SafeArea(
            child: ListView.builder(
              itemCount: _choices.size,
              itemBuilder: (context, index) => _buildListItem(context,
                  choice: _choices[index],
                  onTap: _editChoice,
                  onDismissed: _removeChoice),
            ),
          ),
        ),
        Divider(height: 1.0),
        _buildChoiceComposer()
      ]),
    );
  }

  Widget _buildListItem(BuildContext context,
      {@required Choice choice,
      Function(BuildContext, Choice) onTap,
      Function(BuildContext, Choice) onDismissed}) {
    var removingText = Text(
      "Supprimer",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
    return Dismissible(
      key: Key(choice.name),
      child: ListTile(
          title: Text(choice.name),
          trailing: ChoiceColorSwatch(color: choice.color),
          onTap: () => onTap(context, choice)),
      background: new Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[removingText, Spacer(), removingText],
        ),
      ),
      onDismissed: (_) => onDismissed(context, choice),
    );
  }

  Widget _buildChoiceComposer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: SafeArea(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Add a new choice"),
                    controller: _newChoiceTextController,
                    onSubmitted: (_) => _addNewChoice(),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  iconSize: 38.0,
                  onPressed: _addNewChoice,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeChoice(BuildContext context, Choice choice) {
    setState(() {
      _choices.remove(choice);
    });
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("\"${choice.name}\" was removed")));
  }

  void _addNewChoice() {
    if (_newChoiceTextController.text.isEmpty) return;
    var choiceName = _newChoiceTextController.text;
    var choiceColor = _colors[_choices.size % _colors.length];
    var newChoice = Choice(name: choiceName, color: choiceColor);
    _newChoiceTextController.clear();
    setState(() {
      _choices.add(newChoice);
    });
  }

  void _editChoice(BuildContext context, final Choice choice) {
    final futureChoice = showModalBottomSheet(
        context: context, builder: (context) => ChoiceEditor(choice: choice));
    futureChoice.then((editedChoice) {
      if (editedChoice is Choice) {
        setState(() {
          _choices.change(from: choice, to: editedChoice);
        });
      }
    });
  }
}

final _colors = <Color>[
  Colors.brown,
  Colors.indigo,
  Colors.red,
  Colors.yellow,
  Colors.cyan,
  Colors.green,
  Colors.amber,
  Colors.blue,
  Colors.deepPurple,
  Colors.teal
];
