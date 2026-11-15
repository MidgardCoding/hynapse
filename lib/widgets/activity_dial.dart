import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ActivityDial extends StatefulWidget {
  const ActivityDial({
    super.key,
    required this.readiness,
    required this.onSegmentTap,
    this.completedSegments = 0,
  });

  final int readiness;
  final ValueChanged<int> onSegmentTap;
  final int completedSegments;

  @override
  State<ActivityDial> createState() => _ActivityDialState();
}

class _ActivityDialState extends State<ActivityDial> {
  int? _selected;

  static const _icons = [
    Icons.mic_none_rounded,
    Icons.psychology_alt_rounded,
    Icons.monitor_heart_outlined,
    Icons.satellite_alt_rounded,
  ];

  static const _colors = [
    AppColors.cyan,
    AppColors.green,
    AppColors.amber,
    Color(0xFF5689FF),
  ];

  void _handleTap(Offset local, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = local - center;
    var angle = math.atan2(delta.dy, delta.dx);
    angle += math.pi / 2;
    if (angle < 0) angle += math.pi * 2;
    final index = ((angle / (math.pi / 2)).floor()) % 4;
    setState(() => _selected = index);
    widget.onSegmentTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        final selected = _selected;
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) => _handleTap(details.localPosition, Size(size, size)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: _ActivityDialPainter(
                      selectedIndex: selected,
                      readiness: widget.readiness,
                      completedSegments: widget.completedSegments,
                      icons: _icons,
                      colors: _colors,
                    ),
                  ),
                  for (var i = 0; i < 4; i++)
                    _DialIcon(
                      index: i,
                      size: size,
                      icon: _icons[i],
                      color: _colors[i],
                      selected: selected == i,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DialIcon extends StatelessWidget {
  const _DialIcon({
    required this.index,
    required this.size,
    required this.icon,
    required this.color,
    required this.selected,
  });

  final int index;
  final double size;
  final IconData icon;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final midAngle = -math.pi / 2 + math.pi / 4 + index * math.pi / 2;
    final radius = size * 0.365;
    final center = size / 2;
    final dx = center + math.cos(midAngle) * radius;
    final dy = center + math.sin(midAngle) * radius;
    final iconSize = size * 0.058;

    return Positioned(
      left: dx - iconSize,
      top: dy - iconSize,
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: selected ? 1 : 0.82,
          child: Icon(
            icon,
            size: iconSize * 2,
            color: Colors.white.withValues(alpha: selected ? 1 : 0.82),
            shadows: [
              Shadow(
                color: color.withValues(alpha: 0.55),
                blurRadius: selected ? 16 : 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityDialPainter extends CustomPainter {
  _ActivityDialPainter({
    required this.selectedIndex,
    required this.readiness,
    required this.completedSegments,
    required this.icons,
    required this.colors,
  });

  final int? selectedIndex;
  final int readiness;
  final int completedSegments;
  final List<IconData> icons;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outer = size.width / 2;
    final ringWidth = size.width * 0.095;
    final arcRadius = outer - ringWidth * 0.72;

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth
      ..strokeCap = StrokeCap.butt
      ..color = const Color(0xFF343943);
    canvas.drawCircle(center, arcRadius, base);

    final outerBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.018
      ..color = const Color(0xFF1B1D24);
    canvas.drawCircle(center, outer - size.width * 0.012, outerBorder);

    final innerBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withValues(alpha: 0.08);
    canvas.drawCircle(center, outer - ringWidth * 1.26, innerBorder);
    canvas.drawCircle(center, outer - ringWidth * 0.16, innerBorder);

    final gap = 0.016;
    final rect = Rect.fromCircle(center: center, radius: arcRadius);
    for (var i = 0; i < 4; i++) {
      final isSelected = selectedIndex == i;
      var color = colors[i];
      if (selectedIndex != null && !isSelected) {
        color = color.withValues(alpha: 0.42);
      }
      final shader = SweepGradient(
        startAngle: -math.pi / 2 + i * math.pi / 2,
        endAngle: -math.pi / 2 + (i + 1) * math.pi / 2,
        colors: [
          color.withValues(alpha: isSelected ? 1 : 0.88),
          Color.lerp(color, Colors.white, 0.16)!
              .withValues(alpha: isSelected ? 1 : 0.72),
        ],
      ).createShader(rect);

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringWidth
        ..strokeCap = StrokeCap.butt
        ..shader = shader;
      if (isSelected) {
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      }
      final start = -math.pi / 2 + i * math.pi / 2 + gap;
      final sweep = math.pi / 2 - gap * 2;
      canvas.drawArc(rect, start, sweep, false, paint);
    }

    final gloss = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.16),
          Colors.transparent,
          Colors.black.withValues(alpha: 0.16),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: outer));
    canvas.drawCircle(
      center,
      outer - size.width * 0.012,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.018
        ..shader = gloss.shader,
    );

    final centerRadius = size.width * 0.292;
    final centerPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.35, -0.45),
        colors: [Color(0xFF4A505C), Color(0xFF252A34), Color(0xFF1C2029)],
        stops: [0, 0.6, 1],
      ).createShader(Rect.fromCircle(center: center, radius: centerRadius));
    canvas.drawCircle(center, centerRadius, centerPaint);

    final centerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.white.withValues(alpha: 0.10);
    canvas.drawCircle(center, centerRadius, centerRing);
    canvas.drawCircle(
      center,
      centerRadius * 0.84,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = Colors.white.withValues(alpha: 0.06),
    );

    final glossCenter = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.09),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: centerRadius));
    canvas.drawCircle(center, centerRadius, glossCenter);

    _paintText(
      canvas,
      center.translate(0, -size.height * 0.002),
      '$readiness',
      TextStyle(
        fontFamily: 'Bungee',
        fontSize: size.width * 0.20,
        fontWeight: FontWeight.w700,
        height: 0.8,
        color: Colors.white,
      ),
    );
    _paintText(
      canvas,
      center.translate(0, size.height * 0.095),
      'GOTOWOŚĆ',
      TextStyle(
        fontFamily: 'SansExpanded',
        fontSize: size.width * 0.034,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
        color: Colors.white.withValues(alpha: 0.54),
      ),
    );

    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 1;
    for (var i = 0; i < 36; i++) {
      final angle = i * math.pi / 18;
      final start = center +
          Offset(math.cos(angle), math.sin(angle)) * (outer - size.width * 0.035);
      final end = center +
          Offset(math.cos(angle), math.sin(angle)) * (outer - size.width * 0.047);
      canvas.drawLine(start, end, tickPaint);
    }
  }

  void _paintText(
    Canvas canvas,
    Offset center,
    String text,
    TextStyle style,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, center.dy - painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _ActivityDialPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.readiness != readiness ||
        oldDelegate.completedSegments != completedSegments;
  }
}
