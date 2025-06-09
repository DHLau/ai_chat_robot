import 'package:flutter/material.dart';
import 'dart:math';

class RingWithGap extends StatelessWidget {
  final double diameterCm;
  final double strokeWidth;
  final Color color;
  final double startAngleDeg;
  final double sweepAngleDeg;

  const RingWithGap({
    super.key,
    required this.diameterCm,
    required this.strokeWidth,
    required this.color,
    required this.startAngleDeg,
    required this.sweepAngleDeg,
  });

  @override
  Widget build(BuildContext context) {
    // 估算1cm ≈ 38逻辑像素（具体值可用 DPI 来算）
    final logicalPixels = diameterCm * 38;

    return CustomPaint(
      size: Size(logicalPixels, logicalPixels),
      painter: RingPainter(
        strokeWidth: strokeWidth,
        color: color,
        startAngleDeg: startAngleDeg,
        sweepAngleDeg: sweepAngleDeg,
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double startAngleDeg;
  final double sweepAngleDeg;

  RingPainter({
    required this.strokeWidth,
    required this.color,
    required this.startAngleDeg,
    required this.sweepAngleDeg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // 弧线起始角和角度（单位为弧度）
    final startAngleRad = startAngleDeg * pi / 180;
    final sweepAngleRad = sweepAngleDeg * pi / 180;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleRad,
      sweepAngleRad,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
