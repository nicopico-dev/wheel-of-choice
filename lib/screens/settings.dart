import 'package:flutter/material.dart';
import 'package:wheel_of_choice/colors.dart';
import 'package:wheel_of_choice/components/choice_color_swatch.dart';
import 'package:wheel_of_choice/data/choice.dart';
import 'package:wheel_of_choice/data/persistence.dart';
import 'package:wheel_of_choice/screens/choice_editor.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Persistence persistence = Persistence();
  final _newChoiceTextController = TextEditingController();
  bool _validChoiceName = false;

  // FIXME Change on choices are a side-effect of modifying the global choices
  List<Choice> _choices;

  @override
  Widget build(BuildContext context) {
    _choices = ChoiceProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(children: <Widget>[
        Flexible(
          child: SafeArea(
            child: ListView.builder(
              itemCount: _choices.length,
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
                    onChanged: (value) => setState(() {
                          _validChoiceName = value.isNotEmpty;
                        }),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  iconSize: 38.0,
                  onPressed: _validChoiceName ? _addNewChoice : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNewChoice() {
    if (_newChoiceTextController.text.isEmpty) return;
    var choiceName = _newChoiceTextController.text;
    var choiceColor = choiceColors[_choices.length % choiceColors.length];
    var newChoice = Choice(name: choiceName, color: choiceColor);
    _newChoiceTextController.clear();
    setState(() {
      _choices.add(newChoice);
      _validChoiceName = false;
    });
  }

  void _editChoice(BuildContext context, final Choice choice) {
    final futureChoice = showModalBottomSheet(
      context: context,
      builder: (context) => ChoiceEditor(choice: choice),
    );
    futureChoice.then((editedChoice) {
      if (editedChoice is Choice) {
        setState(() {
          var index = _choices.indexOf(choice);
          _choices
            ..removeAt(index)
            ..insert(index, editedChoice);
        });
      } else if (editedChoice == "DELETE") {
        _removeChoice(context, choice);
      }
    });
  }

  void _removeChoice(BuildContext context, Choice choice) {
    setState(() => _choices.remove(choice));
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("\"${choice.name}\" was removed")));
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    persistence.save(_choices);
  }
}
