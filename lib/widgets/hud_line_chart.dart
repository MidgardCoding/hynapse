import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HudLineChart extends StatelessWidget {
  const HudLineChart({
    super.key,
    required this.values,
    this.labels = const [],
    this.color = AppColors.green,
    this.height = 150,
    this.minValue,
    this.maxValue,
    this.unit = '',
  });

  final List<double> values;
  final List<String> labels;
  final Color color;
  final double height;
  final double? minValue;
  final double? maxValue;
  final String unit;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Brak danych do wyświetlenia',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _LineChartPainter(
          values: values,
          labels: labels,
          color: color,
          minValue: minValue,
          maxValue: maxValue,
          textColor: Colors.white.withValues(alpha: 0.46),
          gridColor: Colors.white.withValues(alpha: 0.10),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.values,
    required this.labels,
    required this.color,
    required this.minValue,
    required this.maxValue,
    required this.textColor,
    required this.gridColor,
  });

  final List<double> values;
  final List<String> labels;
  final Color color;
  final double? minValue;
  final double? maxValue;
  final Color textColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    const leftPadding = 38.0;
    const rightPadding = 8.0;
    const topPadding = 12.0;
    const bottomPadding = 25.0;
    final chartWidth = size.width - leftPadding - rightPadding;
    final chartHeight = size.height - topPadding - bottomPadding;

    var low = minValue ?? values.reduce(math.min);
    var high = maxValue ?? values.reduce(math.max);
    if (low == high) {
      low -= 1;
      high += 1;
    }
    final padding = (high - low) * 0.18;
    low -= padding;
    high += padding;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8;
    const gridLines = 4;
    final textStyle = TextStyle(
      fontSize: 9,
      color: textColor,
      fontFamily: 'SansExpanded',
    );

    for (var i = 0; i < gridLines; i++) {
      final y = topPadding + chartHeight * i / (gridLines - 1);
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );
      final value = high - (high - low) * i / (gridLines - 1);
      _paintText(
        canvas,
        value.toStringAsFixed(value.abs() >= 100 ? 0 : 1),
        Offset(0, y - 6),
        textStyle,
      );
    }

    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final x = values.length == 1
          ? leftPadding + chartWidth / 2
          : leftPadding + chartWidth * i / (values.length - 1);
      final normalized = (values[i] - low) / (high - low);
      final y = topPadding + chartHeight * (1 - normalized);
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final controlX = (previous.dx + current.dx) / 2;
      path.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
    }

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, topPadding + chartHeight)
      ..lineTo(points.first.dx, topPadding + chartHeight)
      ..close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromLTWH(leftPadding, topPadding, chartWidth, chartHeight),
        ),
    );

    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.40)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawPath(path, glowPaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, linePaint);

    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      canvas.drawCircle(
        point,
        4.4,
        Paint()..color = color.withValues(alpha: 0.22),
      );
      canvas.drawCircle(point, 2.3, Paint()..color = color);

      if (i < labels.length) {
        final painter = TextPainter(
          text: TextSpan(text: labels[i], style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        painter.paint(
          canvas,
          Offset(
            (point.dx - painter.width / 2)
                .clamp(0.0, size.width - painter.width),
            size.height - bottomPadding + 8,
          ),
        );
      }
    }
  }

  void _paintText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.labels != labels ||
        oldDelegate.color != color;
  }
}
