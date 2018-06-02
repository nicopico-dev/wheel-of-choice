import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wheel_of_choice/data.dart';

class ChoiceWheel extends StatelessWidget {
  final _WheelPainter _painter;

  ChoiceWheel({ChoiceData choices}) : _painter = _WheelPainter(choices.values);

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
}

const MIN_SECTION_COUNT = 5;

class _WheelPainter extends CustomPainter {
  List<_Section> _sections;

  _WheelPainter(Iterable<Choice> choices) {
    var paddedChoices = _padChoices(choices);

    final sweepAngle = (2 * pi) / paddedChoices.length;
    var startAngle = 0.0;
    _sections = paddedChoices.map((c) {
      var section = _Section(c, startAngle, sweepAngle);
      startAngle = section.endAngle;
      return section;
    }).toList();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final radius = min(size.height, size.width);
    final rect = Rect.fromLTWH(0.0, 0.0, radius, radius);

    for (var s in _sections) {
      canvas.drawArc(
          rect, s.startAngle, s.sweepAngle, true, paint..color = s.color);
    }
  }

  @override
  bool shouldRepaint(_WheelPainter oldDelegate) {
    return !ListEquality().equals(_sections, oldDelegate._sections);
  }
}

Iterable<Choice> _padChoices(Iterable<Choice> choices) {
  if (choices.length >= MIN_SECTION_COUNT || choices.length == 0) {
    return choices;
  } else {
    return _padChoices(choices.followedBy(choices));
  }
}

class _Section {
  final Choice choice;
  final double startAngle;
  final double sweepAngle;

  const _Section(this.choice, this.startAngle, this.sweepAngle);

  double get endAngle => startAngle + sweepAngle;
  String get label => choice.name;
  Color get color => choice.color;
}
