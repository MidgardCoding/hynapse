import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HynapseMark extends StatelessWidget {
  const HynapseMark({
    super.key,
    this.size = 180,
    this.color = Colors.white,
    this.glow = true,
  });

  final double size;
  final Color color;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: size,
        height: size,
        decoration: glow
            ? BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.12),
                    blurRadius: size * 0.25,
                    spreadRadius: size * 0.02,
                  ),
                ],
              )
            : null,
        child: CustomPaint(
          painter: _HynapseMarkPainter(color),
        ),
      ),
    );
  }
}

class _HynapseMarkPainter extends CustomPainter {
  _HynapseMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final left = Path()
      ..moveTo(w * 0.20, h * 0.20)
      ..quadraticBezierTo(w * 0.20, h * 0.155, w * 0.245, h * 0.175)
      ..lineTo(w * 0.385, h * 0.245)
      ..lineTo(w * 0.385, h * 0.755)
      ..quadraticBezierTo(w * 0.385, h * 0.82, w * 0.325, h * 0.80)
      ..lineTo(w * 0.20, h * 0.735)
      ..close();

    final right = Path()
      ..moveTo(w * 0.80, h * 0.20)
      ..quadraticBezierTo(w * 0.80, h * 0.155, w * 0.755, h * 0.175)
      ..lineTo(w * 0.615, h * 0.245)
      ..lineTo(w * 0.615, h * 0.755)
      ..quadraticBezierTo(w * 0.615, h * 0.82, w * 0.675, h * 0.80)
      ..lineTo(w * 0.80, h * 0.735)
      ..close();

    canvas.drawPath(left, paint);
    canvas.drawPath(right, paint);

    final ribbon = Path()..fillType = PathFillType.evenOdd;
    ribbon
      ..moveTo(w * 0.255, h * 0.685)
      ..cubicTo(
        w * 0.33,
        h * 0.58,
        w * 0.44,
        h * 0.55,
        w * 0.535,
        h * 0.565,
      )
      ..cubicTo(
        w * 0.635,
        h * 0.58,
        w * 0.69,
        h * 0.535,
        w * 0.765,
        h * 0.445,
      )
      ..cubicTo(
        w * 0.69,
        h * 0.51,
        w * 0.63,
        h * 0.49,
        w * 0.53,
        h * 0.475,
      )
      ..cubicTo(
        w * 0.42,
        h * 0.46,
        w * 0.30,
        h * 0.51,
        w * 0.205,
        h * 0.625,
      )
      ..close();

    canvas.drawPath(ribbon, paint);

    final glint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.32),
          Colors.transparent,
          AppColors.cyan.withValues(alpha: 0.16),
        ],
        stops: const [0, 0.55, 1],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(left, glint);
    canvas.drawPath(right, glint);

    final accent = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(0.9, w * 0.006)
      ..strokeCap = StrokeCap.round;
    final accentPath = Path()
      ..moveTo(w * 0.28, h * 0.66)
      ..cubicTo(
        w * 0.36,
        h * 0.57,
        w * 0.45,
        h * 0.55,
        w * 0.54,
        h * 0.56,
      );
    canvas.drawPath(accentPath, accent);
  }

  @override
  bool shouldRepaint(covariant _HynapseMarkPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
