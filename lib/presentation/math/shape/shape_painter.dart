import 'dart:math';

import 'package:flutter/cupertino.dart';

class ShapePainter extends CustomPainter {
  final int sides;
  final Color color;

  ShapePainter({required this.sides, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    final angle = (2 * pi) / sides;
    final radius = min(size.width / 2, size.height / 2);

    for (int i = 0; i < sides; i++) {
      final x = size.width / 2 + radius * cos(i * angle);
      final y = size.height / 2 + radius * sin(i * angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}