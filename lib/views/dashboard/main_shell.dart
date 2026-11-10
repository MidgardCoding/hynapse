import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/hud_bottom_nav.dart';
import '../../widgets/hud_route.dart';
import '../emergency/emergency_screen.dart';
import '../settings/settings_screen.dart';
import 'dashboard_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(todaySummaryProvider).valueOrNull;
    final pending = 3 - (summary?.completedTasks ?? 0);

    void openEmergency() {
      Navigator.of(context).push(hudRoute(const EmergencyScreen()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AppBackground(
        child: IndexedStack(
          index: _index,
          children: [
            DashboardScreen(
              onOpenSettings: () => setState(() => _index = 1),
              onOpenEmergency: openEmergency,
            ),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: HudBottomNav(
        index: _index,
        pendingCount: pending,
        onSelect: (value) => setState(() => _index = value),
        onEmergency: openEmergency,
      ),
    );
  }
}
