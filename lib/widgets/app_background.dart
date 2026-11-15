import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.accent = AppColors.electricBlue,
    this.danger = false,
    this.showGrid = true,
  });

  final Widget child;
  final Color accent;
  final bool danger;
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    final colors = danger
        ? const [
            Color(0xFF090102),
            Color(0xFF28040A),
            Color(0xFF8A0711),
          ]
        : const [
            AppColors.backgroundDeep,
            AppColors.background,
            AppColors.electricBlue,
          ];

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
              stops: const [0, 0.46, 1],
            ),
          ),
        ),
        Positioned(
          top: -MediaQuery.sizeOf(context).height * 0.22,
          right: -MediaQuery.sizeOf(context).width * 0.28,
          child: _Glow(
            color: danger ? AppColors.danger : AppColors.cyan,
            size: MediaQuery.sizeOf(context).width * 0.9,
            opacity: danger ? 0.18 : 0.10,
          ),
        ),
        Positioned(
          bottom: -MediaQuery.sizeOf(context).height * 0.18,
          left: -MediaQuery.sizeOf(context).width * 0.35,
          child: _Glow(
            color: accent,
            size: MediaQuery.sizeOf(context).width,
            opacity: danger ? 0.22 : 0.34,
          ),
        ),
        if (showGrid)
          IgnorePointer(
            child: CustomPaint(
              painter: _HudGridPainter(
                color: Colors.white,
                danger: danger,
              ),
            ),
          ),
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.15, -0.3),
                radius: 1.2,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: danger ? 0.35 : 0.24),
                ],
                stops: const [0.55, 1],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({
    required this.color,
    required this.size,
    required this.opacity,
  });

  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: opacity), Colors.transparent],
          ),
        ),
      ),
    );
  }
}

class _HudGridPainter extends CustomPainter {
  _HudGridPainter({required this.color, required this.danger});

  final Color color;
  final bool danger;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color.withValues(alpha: danger ? 0.025 : 0.022)
      ..strokeWidth = 1;
    const spacing = 48.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final random = math.Random(1977);
    final starPaint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 55; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.15 + 0.2;
      final opacity = random.nextDouble() * 0.30 + 0.05;
      starPaint.color = color.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

    final corner = Paint()
      ..color = (danger ? AppColors.danger : AppColors.cyan)
          .withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final length = size.shortestSide * 0.08;
    final inset = size.shortestSide * 0.035;
    final corners = <Offset>[
      Offset(inset, inset),
      Offset(size.width - inset, inset),
      Offset(inset, size.height - inset),
      Offset(size.width - inset, size.height - inset),
    ];
    for (final point in corners) {
      final xSign = point.dx < size.width / 2 ? 1 : -1;
      final ySign = point.dy < size.height / 2 ? 1 : -1;
      canvas.drawLine(
        point,
        point + Offset(length * xSign, 0),
        corner,
      );
      canvas.drawLine(
        point,
        point + Offset(0, length * ySign),
        corner,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HudGridPainter oldDelegate) {
    return oldDelegate.danger != danger || oldDelegate.color != color;
  }
}
