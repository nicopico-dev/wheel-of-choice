import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';
import 'package:wheel_of_choice/color_picker.dart';

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
  Color _color;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.choice.name;
    _color = widget.choice.color;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
              SizedBox(height: 16.0),
              ColorPicker(
                currentColor: widget.choice.color,
                onColorChanged: _onColorChanged,
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => _onCancelled(context)),
              FlatButton(
                  child: Text("Save"),
                  textColor: theme.primaryColorDark,
                  onPressed: () => _onSaved(context)),
            ],
          ),
        )
      ],
    );
  }

  void _onColorChanged(Color color) {
    setState(() => _color = color);
  }

  void _onCancelled(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSaved(BuildContext context) {
    var editedChoice = Choice(name: _textController.text, color: _color);
    Navigator.of(context).pop(editedChoice);
  }
}
