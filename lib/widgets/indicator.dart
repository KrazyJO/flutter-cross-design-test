import 'package:flutter/material.dart';

class Indicator extends CustomPainter {
  final double value;
  final Color color;
  Indicator({
    required this.value,
    required this.color,
  }) : assert(value >= 0 && value <= 1);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final angle = 6.2832 * value;

    canvas.drawArc(
      const Offset(0, 0) & const Size(120, 120),
      -1.5708,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}