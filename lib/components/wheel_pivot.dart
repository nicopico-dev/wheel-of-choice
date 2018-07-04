import 'dart:math';

import 'package:flutter/widgets.dart';

class WheelPivot extends StatelessWidget {
  final _painter = const _PivotPainter();

  const WheelPivot();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final radius = min(constraints.maxWidth, constraints.maxHeight);
      return CustomPaint(
        painter: _painter,
        size: Size.square(radius),
      );
    });
  }
}

class _PivotPainter extends CustomPainter {
  const _PivotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var pivotOffset = size.center(Offset(0.0, 0.0));
    var centerRadius = min(size.height, size.width) * .125;
    var paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(.1, -.12),
        radius: .6,
        colors: <Color>[
          Color.fromARGB(255, 255, 215, 0),
          Color.fromARGB(255, 218, 165, 32),
        ],
      ).createShader(Rect.fromCircle(
        center: pivotOffset,
        radius: centerRadius,
      ));
    canvas.drawCircle(pivotOffset, centerRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
