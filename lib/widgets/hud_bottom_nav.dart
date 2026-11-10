import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HudBottomNav extends StatelessWidget {
  const HudBottomNav({
    super.key,
    required this.index,
    required this.onSelect,
    required this.onEmergency,
    this.pendingCount = 0,
  });

  final int index;
  final ValueChanged<int> onSelect;
  final VoidCallback onEmergency;
  final int pendingCount;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: EdgeInsets.only(bottom: bottomInset),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0E20).withValues(alpha: 0.80),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: SizedBox(
            height: 68,
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    icon: Icons.warning_amber_rounded,
                    label: 'Awaryjny',
                    color: AppColors.danger,
                    selected: false,
                    onTap: onEmergency,
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Pulpit',
                    color: AppColors.cyan,
                    selected: index == 0,
                    onTap: () => onSelect(0),
                  ),
                ),
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      _NavItem(
                        icon: Icons.settings_rounded,
                        label: 'Ustawienia',
                        color: AppColors.textSecondary,
                        selected: index == 1,
                        onTap: () => onSelect(1),
                      ),
                      if (pendingCount > 0)
                        Positioned(
                          top: 8,
                          right: MediaQuery.sizeOf(context).width * 0.15,
                          child: Container(
                            width: 17,
                            height: 17,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF0B0E20),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '$pendingCount',
                              style: const TextStyle(
                                fontSize: 8,
                                height: 1,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: selected
                  ? color.withValues(alpha: 0.14)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 23,
              color: selected ? color : Colors.white.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: selected ? color : Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}
