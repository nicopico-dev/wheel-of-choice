import 'package:flutter/material.dart';

class Needle extends StatelessWidget {
  final _painter = _NeedlePainter();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: Size.infinite,
    );
  }
}

class _NeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red;
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
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
