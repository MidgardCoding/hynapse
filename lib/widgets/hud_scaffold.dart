import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_background.dart';

enum HudLeading { back, menu, none }

class HudScaffold extends StatelessWidget {
  const HudScaffold({
    super.key,
    required this.title,
    required this.body,
    this.leading = HudLeading.back,
    this.onLeadingTap,
    this.actions = const [],
    this.accent = AppColors.electricBlue,
    this.danger = false,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.showGrid = true,
    this.backgroundColors,
    this.transparentAppBar = false,
  });

  final String title;
  final Widget body;
  final HudLeading leading;
  final VoidCallback? onLeadingTap;
  final List<Widget> actions;
  final Color accent;
  final bool danger;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool showGrid;
  final List<Color>? backgroundColors;
  final bool transparentAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      body: AppBackground(
        accent: accent,
        danger: danger,
        showGrid: showGrid,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              HudAppBar(
                title: title,
                leading: leading,
                onLeadingTap: onLeadingTap,
                actions: actions,
                danger: danger,
                transparent: transparentAppBar,
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}

class HudAppBar extends StatelessWidget {
  const HudAppBar({
    super.key,
    required this.title,
    this.leading = HudLeading.back,
    this.onLeadingTap,
    this.actions = const [],
    this.danger = false,
    this.transparent = false,
  });

  final String title;
  final HudLeading leading;
  final VoidCallback? onLeadingTap;
  final List<Widget> actions;
  final bool danger;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final leadingWidget = switch (leading) {
      HudLeading.back => _RoundIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onLeadingTap ?? () => Navigator.of(context).maybePop(),
          danger: danger,
        ),
      HudLeading.menu => _RoundIconButton(
          icon: Icons.menu_rounded,
          onTap: onLeadingTap ?? () {},
          danger: danger,
        ),
      HudLeading.none => const SizedBox(width: 40),
    };

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: BoxDecoration(
        gradient: transparent
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: danger ? 0.52 : 0.40),
                  Colors.transparent,
                ],
              ),
      ),
      child: Row(
        children: [
          leadingWidget,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    letterSpacing: 0.7,
                    color: AppColors.textPrimary,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    required this.danger,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.10),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 22,
            color: danger ? AppColors.danger : Colors.white,
          ),
        ),
      ),
    );
  }
}

class HudMenuAction extends StatelessWidget {
  const HudMenuAction({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = AppColors.textPrimary,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.white.withValues(alpha: 0.09),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
