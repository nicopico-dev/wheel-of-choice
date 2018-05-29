import 'package:flutter/material.dart';
import 'package:wheel_of_choice/choice_color_swatch.dart';
import 'package:wheel_of_choice/colors.dart';

class ColorPicker extends StatefulWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({this.currentColor, @required this.onColorChanged});

  @override
  _ColorPickerState createState() => new _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = choiceColors.map((color) {
      return ChoiceColorSwatch(
        color: color,
        swatchedSize: SwatchSize.Big,
        selected: color == _currentColor,
        onColorSelected: () => onColorChanged(color),
      );
    }).toList();
    return Wrap(
      children: children,
      spacing: 8.0,
      runSpacing: 8.0,
    );
  }

  void onColorChanged(Color color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }
}
