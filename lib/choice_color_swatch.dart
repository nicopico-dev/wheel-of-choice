import 'package:flutter/material.dart';

class ChoiceColorSwatch extends StatelessWidget {
  final Color color;
  final bool selected;
  final SwatchSize swatchedSize;
  final VoidCallback onColorSelected;

  const ChoiceColorSwatch(
      {Key key,
      @required this.color,
      this.selected = false,
      this.swatchedSize = SwatchSize.Small,
      this.onColorSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = <Widget>[
      InkWell(
        child: Container(
          width: swatchedSize == SwatchSize.Small ? 24.0 : null,
          height: swatchedSize == SwatchSize.Small ? 24.0 : null,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: Border.all(color: Colors.black12),
          ),
        ),
      ),
    ];

    if (this.selected) {
      stackChildren.add(
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white70,
          ),
          child: Icon(Icons.check),
          margin: EdgeInsets.all(4.0),
        ),
      );
    }

    return GestureDetector(
      child: Stack(
        children: stackChildren,
        alignment: AlignmentDirectional(1.0, 1.0),
      ),
      onTap: onColorSelected,
    );
  }
}

enum SwatchSize { Small, Big }
