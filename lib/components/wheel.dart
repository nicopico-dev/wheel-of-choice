import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data/choice.dart';
import 'package:wheel_of_choice/data/section.dart';

class Wheel extends StatelessWidget {
  final _WheelPainter _painter;

  Wheel({@required Iterable<Section> sections})
      : _painter = _WheelPainter(sections);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final radius = min(constraints.maxWidth, constraints.maxHeight);
      return CustomPaint(
        painter: _painter,
        size: Size.square(radius),
        isComplex: true,
      );
    });
  }

  Choice getChoice({double wheelTurns, double needleAngle}) =>
      _painter.getChoice(wheelTurns, needleAngle);
}

const MIN_SECTION_COUNT = 5;

class _WheelPainter extends CustomPainter {
  final Iterable<Section> _sections;

  const _WheelPainter(this._sections);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final diameter = min(size.width, size.height);
    final radius = diameter / 2;
    final rect = Rect.fromLTWH(0.0, 0.0, diameter, diameter);

    final labelSize = 18.0;
    final textOffset = Offset(-16.0, -labelSize / 2);
    final textPainter = (String text) => TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
                color: Colors.white,
                fontSize: labelSize,
                fontWeight: FontWeight.w500),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.end,
        );

    for (var s in _sections) {
      paint.color = s.color;
      canvas.drawArc(rect, s.startAngle, s.sweepAngle, true, paint);

      canvas.save();
      canvas.translate(radius, radius);
      canvas.rotate(s.startAngle + s.sweepAngle / 2);
      textPainter(s.label)
        ..layout(minWidth: radius, maxWidth: radius)
        ..paint(canvas, textOffset);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_WheelPainter oldDelegate) {
    return !IterableEquality().equals(_sections, oldDelegate._sections);
  }

  Choice getChoice(double wheelTurns, double needleAngle) {
    // TODO Handle needleAngle
    var wheelTurnsDecimals = wheelTurns - wheelTurns.truncateToDouble();
    var angle = (1 - wheelTurnsDecimals) * 2 * pi;
    try {
      return _sections
          .firstWhere((s) => s.startAngle <= angle && angle <= s.endAngle)
          .choice;
    } catch (e) {
      debugPrint("WARN: No value for $angle in $_sections");
      return Choice(name: "NONE");
    }
  }
}
