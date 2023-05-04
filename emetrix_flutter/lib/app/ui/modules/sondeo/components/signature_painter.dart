import 'package:flutter/material.dart';

class FirmaPainter extends CustomPainter {
  FirmaPainter(this.points);
  final List<Offset> points;
  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(FirmaPainter other) => other.points != points;
}
