import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';

class ChoiceWheel extends StatelessWidget {
  const ChoiceWheel({this.choices});
  final ChoiceData choices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final radius = min(constraints.maxWidth, constraints.maxHeight);
      return CustomPaint(
        painter: _WheelPainter(choices),
        size: Size.square(radius),
        isComplex: true,
      );
    });
  }
}

class _WheelPainter extends CustomPainter {
  final ChoiceData choices;
  const _WheelPainter(this.choices);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    final radius = min(size.height, size.width);
    final rect = Rect.fromLTWH(0.0, 0.0, radius, radius);
    final sweepAngle = (2 * pi) / choices.size;
    var startAngle = 0.0;

    choices.values.forEach((choice) {
      paint.color = choice.color;
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(_WheelPainter oldDelegate) {
    return !ListEquality()
        .equals(choices.values.toList(), oldDelegate.choices.values.toList());
  }
}
