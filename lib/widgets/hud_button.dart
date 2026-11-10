import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum HudButtonStyle { primary, outline, danger, ghost }

class HudButton extends StatelessWidget {
  const HudButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.style = HudButtonStyle.primary,
    this.expand = true,
    this.height = 56,
    this.color,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final HudButtonStyle style;
  final bool expand;
  final double height;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final accent = color ??
        switch (style) {
          HudButtonStyle.primary => AppColors.cyan,
          HudButtonStyle.outline => AppColors.cyan,
          HudButtonStyle.danger => AppColors.danger,
          HudButtonStyle.ghost => AppColors.textPrimary,
        };

    final decayed = onPressed == null;
    final gradient = style == HudButtonStyle.primary
        ? LinearGradient(
            colors: [
              accent,
              Color.lerp(accent, AppColors.teal, 0.8) ?? accent,
            ],
          )
        : null;

    final background = switch (style) {
      HudButtonStyle.primary => null,
      HudButtonStyle.outline => Colors.white.withValues(alpha: 0.04),
      HudButtonStyle.danger =>
        LinearGradient(colors: [accent, const Color(0xFFC81E2A)]),
      HudButtonStyle.ghost => Colors.transparent,
    };

    final textColor = switch (style) {
      HudButtonStyle.primary => const Color(0xFF001C20),
      HudButtonStyle.outline => accent,
      HudButtonStyle.danger => Colors.white,
      HudButtonStyle.ghost => accent,
    };

    final button = Opacity(
      opacity: decayed ? 0.45 : 1,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: background is Color ? background : null,
          gradient: background is Gradient ? background : gradient,
          borderRadius: BorderRadius.circular(18),
          border: style == HudButtonStyle.outline
              ? Border.all(color: accent.withValues(alpha: 0.55), width: 1.4)
              : null,
          boxShadow: style == HudButtonStyle.primary
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.28),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: textColor),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'SansExpanded',
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.7,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 10),
              trailing!,
            ],
          ],
        ),
      ),
    );

    final interactive = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: button,
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: interactive) : interactive;
  }
}

class HudIconButton extends StatelessWidget {
  const HudIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 48,
    this.color = AppColors.cyan,
    this.filled = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color color;
  final bool filled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: filled ? color.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.08),
      shape: CircleBorder(
        side: BorderSide(color: color.withValues(alpha: 0.28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: color, size: size * 0.46),
        ),
      ),
    );
    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
