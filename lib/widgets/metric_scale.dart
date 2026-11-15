import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MetricScale extends StatelessWidget {
  const MetricScale({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.icon,
    this.inverse = false,
    this.showValue = true,
  });

  final String label;
  final int value;
  final Color color;
  final IconData? icon;
  final bool inverse;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final normalized = (value / 6).clamp(0.0, 1.0);
    final effectiveColor = inverse
        ? (value >= 4 ? AppColors.amber : color)
        : color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: effectiveColor),
              const SizedBox(width: 7),
            ],
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            if (showValue)
              Text(
                '$value / 6',
                style: TextStyle(
                  fontFamily: 'Bungee',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: effectiveColor,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            const totalSegments = 7;
            const gap = 3.0;
            final segmentWidth =
                (constraints.maxWidth - gap * (totalSegments - 1)) /
                    totalSegments;
            return Row(
              children: [
                for (var i = 0; i < totalSegments; i++) ...[
                  if (i > 0) const SizedBox(width: gap),
                  Container(
                    width: segmentWidth,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: i < (normalized * totalSegments).ceil()
                          ? effectiveColor.withValues(alpha: 0.88)
                          : Colors.white.withValues(alpha: 0.09),
                      boxShadow: i < (normalized * totalSegments).ceil()
                          ? [
                              BoxShadow(
                                color: effectiveColor.withValues(alpha: 0.28),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class LabeledProgress extends StatelessWidget {
  const LabeledProgress({
    super.key,
    required this.label,
    required this.value,
    this.color = AppColors.cyan,
    this.trailing,
  });

  final String label;
  final double value;
  final Color color;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: 5,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
