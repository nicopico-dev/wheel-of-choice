import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';

class ChoiceWheel extends StatefulWidget {
  const ChoiceWheel({this.choices});
  final ChoiceData choices;

  @override
  ChoiceWheelState createState() {
    return new ChoiceWheelState();
  }

  _createSection(Choice choice) {
    return Container(
      child: ListTile(title: Text(choice.name)),
      color: choice.color,
    );
  }
}

class ChoiceWheelState extends State<ChoiceWheel> {
  @override
  void initState() {
    super.initState();
    widget.choices.addListener(refresh);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.choices.size,
        itemBuilder: (context, index) =>
            widget._createSection(widget.choices[index]),
      );
  }

  @override
  void dispose() {
    widget.choices.removeListener(refresh);
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }
}
