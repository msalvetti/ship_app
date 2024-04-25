import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCheckmark extends StatelessWidget {
  final double value; // Value should be between 0 and 1
  final Color fillColor;
  final double strokeWidth;

  const CustomCheckmark({
    super.key,
    required this.value,
    required this.fillColor,
    this.strokeWidth = 5.0,
  }) : assert(value >= 0 && value <= 1);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomCheckmarkPainter(
        sweepValue: value,
        fillColor: fillColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _CustomCheckmarkPainter extends CustomPainter {
  final double sweepValue;
  final Color fillColor;
  final double strokeWidth;

  _CustomCheckmarkPainter({
    required this.sweepValue,
    required this.fillColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the outline of the circle
    canvas.drawCircle(
      size.center(Offset.zero),
      (size.width - strokeWidth) / 2,
      paint,
    );

    // Draw the filled part of the circle
    final filledPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    double sweepAngle = 2 * math.pi * sweepValue;
    canvas.drawArc(
      Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: (size.width - strokeWidth) / 2),
      -math.pi / 2, // Start angle at the top of the circle
      sweepAngle,
      true,
      filledPaint,
    );

    // Draw the checkmark if the circle is fully filled (value == 1)
    if (sweepValue == 1.0) {
      final checkPaint = Paint()
        ..color = Colors.white // Use the same fill color for the checkmark
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.square; // Round the ends of the checkmark

      // Define the checkmark path
      final Path checkPath = Path();
      // Starting point of the checkmark (bottom of the first line)
      final Offset start = Offset(size.width * 0.25, size.height * 0.55);
      // Middle point of the checkmark (intersection point)
      final Offset middle = Offset(size.width * 0.45, size.height * 0.7);
      // End point of the checkmark (end of the second line)
      final Offset end = Offset(size.width * 0.75, size.height * 0.3);

      checkPath.moveTo(start.dx, start.dy);
      checkPath.lineTo(middle.dx, middle.dy);
      checkPath.lineTo(end.dx, end.dy);

      // Draw the checkmark path
      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CustomCheckmarkPainter oldDelegate) {
    return sweepValue != oldDelegate.sweepValue;
  }
}
