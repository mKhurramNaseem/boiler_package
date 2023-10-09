import 'dart:math';

import 'package:flutter/material.dart';

class ThermometerPainter extends CustomPainter {
  static const radius = 20.0;
  static const bLeftPoint = 0.0;
  static const bTopPoint = 0.0;
  static const noOfLevels = 21;
  final double topPosition;

  ThermometerPainter({required this.topPosition});
  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final shapeRadius = min(width, height) / 2;

    // Background Paint
    final bPaint = Paint()..color = const Color.fromARGB(255, 221, 212, 130);

    // Draw Thermometer Background
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bLeftPoint, bTopPoint, width, height * 0.9),
          const Radius.circular(
            radius,
          ),
        ),
        bPaint);

    // Center Scale
    final cPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final cLeftPoint = bLeftPoint + width * 0.38;
    final cTopPoint = bTopPoint + height * 0.05;
    final cWidth = width * 0.2;
    final cHeight = height * 0.7;

    // Draw Center Scale
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cLeftPoint, cTopPoint, cWidth, cHeight),
          const Radius.circular(radius),
        ),
        cPaint);

    // Bottom circle
    final bottomCircleRadius = shapeRadius * 0.5;
    final startOffset = Offset(cLeftPoint, cTopPoint);
    final endOffset = Offset(cLeftPoint + cWidth, cTopPoint);
    double y = ((startOffset.dy + endOffset.dy) / 2) + cHeight;
    double x = (startOffset.dx + endOffset.dx) / 2;
    final bottomCircleOffset = Offset(x, y);

    // Draw Bottom Circle
    canvas.drawCircle(bottomCircleOffset, bottomCircleRadius, cPaint);

    // Draw Inner Center Scale
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cLeftPoint, cTopPoint, cWidth, cHeight),
          const Radius.circular(radius),
        ),
        bPaint);

    // Draw Inner Bottom Circle
    canvas.drawCircle(bottomCircleOffset, bottomCircleRadius, bPaint);

    // Red Center Scale
    final rLeftPoint = cLeftPoint + cWidth * 0.32;
    final rTopPoint = cTopPoint + cHeight * topPosition;
    final rWidth = cWidth * 0.35;
    final rHeight = cHeight * (1 - topPosition);
    final rPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw Red Center Scale
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            rLeftPoint,
            rTopPoint,
            rWidth,
            rHeight,
          ),
          const Radius.circular(radius),
        ),
        rPaint);

    // Draw Red Bottom Circle
    canvas.drawCircle(bottomCircleOffset, bottomCircleRadius * 0.75, rPaint);

    // Temperature Levels
    var levelStratPoint =
        Offset(cLeftPoint + cWidth, cTopPoint + cHeight * 0.04);
    final noLevelLength = cWidth * 0.9;
    final levelLength = cWidth * 0.6;
    final levelPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    bool isLongLevel = true;
    int textValue = 50;
    bool isTextValueDec = true;

    // Draw Temp Levels
    for (var i = 0.0; i < noOfLevels; i++) {
      // Line Parameter
      levelStratPoint =
          Offset(cLeftPoint + cWidth, levelStratPoint.dy + cHeight * 0.04);
      double length = isLongLevel ? noLevelLength : levelLength;
      final levelEndPoint =
          Offset(levelStratPoint.dx + length, levelStratPoint.dy);

      // Line Draw
      canvas.drawLine(levelStratPoint, levelEndPoint, levelPaint);

      // Text Parameter
      final textOffset = Offset(
          levelEndPoint.dx + cWidth * 0.2, levelEndPoint.dy - cHeight * 0.014);
      if (isLongLevel) {
        // Text Draw
        TextPainter()
          ..textDirection = TextDirection.ltr
          ..text = TextSpan(
              text: textValue.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: (cWidth + cHeight) / 40))
          ..layout()
          ..paint(canvas, textOffset);
        if (textValue == 0) {
          isTextValueDec = false;
        }
        textValue = isTextValueDec ? textValue - 10 : textValue + 10;
      }

      // Inversion at each step
      isLongLevel = !isLongLevel;
    }
  }

  @override
  bool shouldRepaint(ThermometerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ThermometerPainter oldDelegate) => true;
}
