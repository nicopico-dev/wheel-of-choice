import 'package:flutter/material.dart';
import 'package:wheel_of_choice/colors.dart';

class Needle extends StatelessWidget {
  final _painter = const _NeedlePainter();

  const Needle();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: Size(70.0, 30.0),
    );
  }
}

class _NeedlePainter extends CustomPainter {
  const _NeedlePainter();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(size.width, 0.0)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width, size.height)
      ..arcToPoint(
        Offset(size.width, 0.0),
        radius: Radius.circular(size.height / 2.0),
        clockwise: false,
      )
      ..close();
    canvas.drawShadow(path, Colors.grey, 2.0, false);
    canvas.drawPath(path, _fillPaint);
    canvas.drawPath(path, defaultStrokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

final _fillPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.red;
