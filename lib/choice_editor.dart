import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';

class ChoiceEditor extends StatefulWidget {
  final Choice choice;
  ChoiceEditor({this.choice});

  @override
  ChoiceEditorState createState() {
    return new ChoiceEditorState();
  }
}

class ChoiceEditorState extends State<ChoiceEditor> {
  final TextEditingController _textController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _textController.text = widget.choice.name;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                "Edition",
                style: theme.textTheme.title,
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(hintText: "Choice name"),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
        Spacer(),
        ButtonBar(
          children: <Widget>[
            FlatButton(
                child: Text("Cancel"), onPressed: () => _onCancelled(context)),
            FlatButton(
                child: Text("Save"),
                textColor: theme.primaryColorDark,
                onPressed: () => _onSaved(context)),
          ],
        )
      ],
    );
  }

  void _onCancelled(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSaved(BuildContext context) {
    // TODO Handle color update
    var editedChoice = Choice(name: _textController.text, color: widget.choice.color);
    Navigator.of(context).pop(editedChoice);
  }
}
