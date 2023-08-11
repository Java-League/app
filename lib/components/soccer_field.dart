import 'package:flutter/material.dart';

class SoccerField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FieldPainter(),
    );
  }
}

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Linhas do campo
    canvas.drawRect(Offset(0, 0) & size, paint);

    // Meio de campo
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), paint);

    // Retângulos da área
    final double rectWidth = size.width * 0.4;
    final double rectHeight = size.height * 0.15;

    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX, rectHeight / 2), width: rectWidth, height: rectHeight),
        paint);

    canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX, size.height - rectHeight / 2), width: rectWidth, height: rectHeight),
        paint);

    // Bola central
    final ballRadius = 20.0;
    canvas.drawCircle(Offset(centerX, centerY), ballRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}