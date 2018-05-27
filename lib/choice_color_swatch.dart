import 'package:flutter/material.dart';

class ChoiceColorSwatch extends StatelessWidget {
  final Color color;

  const ChoiceColorSwatch({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(24.0, 24.0),
      painter: _SquarePainter(this.color),
    );
  }
}

class _SquarePainter extends CustomPainter {
  final Color _color;

  _SquarePainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        Paint()..color = this._color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}