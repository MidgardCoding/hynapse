import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/hynapse_mark.dart';
import '../../widgets/section_title.dart';
import '../welcome/welcome_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider).valueOrNull;
    final stats = ref.watch(profileStatsProvider).valueOrNull;
    final name = session?.displayName ?? 'Rafał';

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const HudAppBar(title: 'Ustawienia', leading: HudLeading.none),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              child: ContentWidth(
                maxWidth: 640,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 18),
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.07),
                              border: Border.all(
                                color: AppColors.cyan.withValues(alpha: 0.28),
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const HynapseMark(size: 40, glow: false),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 24),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  session?.role == 'astronaut'
                                      ? 'ASTRONAUTA · ORBITA LEO'
                                      : 'OPERATOR NAZIEMNY',
                                  style: TextStyle(
                                    fontSize: 8.5,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.cyan.withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  session?.userId ?? '—',
                                  style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 0.5,
                                    color: Colors.white.withValues(alpha: 0.38),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const StatusPill(
                            label: 'Autoryzowany',
                            color: AppColors.green,
                            compact: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: _StatTile(
                            value: '${stats?.dailyLogCount ?? 0}',
                            label: 'Check-iny',
                            icon: Icons.mic_none_rounded,
                            color: AppColors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatTile(
                            value: '${stats?.testCount ?? 0}',
                            label: 'Testy',
                            icon: Icons.psychology_alt_rounded,
                            color: AppColors.cyan,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatTile(
                            value: stats == null
                                ? '—'
                                : stats.averageReadiness.toStringAsFixed(1),
                            label: 'Gotowość',
                            icon: Icons.track_changes_rounded,
                            color: AppColors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: 'Konto i sesja'),
                    GlassCard(
                      padding: EdgeInsets.zero,
                      radius: 20,
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.badge_outlined,
                            title: 'Identyfikator operatora',
                            value: session?.userId ?? 'Brak sesji',
                          ),
                          _rowDivider(),
                          _InfoRow(
                            icon: Icons.sync_rounded,
                            title: 'Ostatnia synchronizacja',
                            value: _formatDate(session?.lastSync),
                          ),
                          _rowDivider(),
                          const _InfoRow(
                            icon: Icons.shield_outlined,
                            title: 'Tryb pracy',
                            value: 'Offline-first · lokalna stacja',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: 'Diagnostyka'),
                    GlassCard(
                      padding: EdgeInsets.zero,
                      radius: 20,
                      child: Column(
                        children: [
                          const _InfoRow(
                            icon: Icons.storage_rounded,
                            title: 'Baza danych',
                            value: 'Isar 3.4 · aktywna',
                            accent: AppColors.green,
                          ),
                          _rowDivider(),
                          _InfoRow(
                            icon: Icons.timer_outlined,
                            title: 'Średni czas reakcji',
                            value: stats == null || stats.averageReaction == 0
                                ? 'Brak danych'
                                : '${stats.averageReaction.round()} ms',
                          ),
                          _rowDivider(),
                          const _InfoRow(
                            icon: Icons.memory_rounded,
                            title: 'Wersja aplikacji',
                            value: 'Hynapse 0.1.0 (HT-1)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: 'Prywatność'),
                    Text(
                      'Dane profilu, dziennik check-inów, wyniki testów oraz status '
                      'procedur awaryjnych są przechowywane wyłącznie w lokalnej bazie '
                      'Isar. Synchronizacja następuje dopiero po autoryzacji operatora.',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.55,
                        color: Colors.white.withValues(alpha: 0.42),
                      ),
                    ),
                    const SizedBox(height: 26),
                    HudButton(
                      label: 'Wyloguj',
                      icon: Icons.logout_rounded,
                      style: HudButtonStyle.outline,
                      color: AppColors.danger,
                      onPressed: () => _logout(context, ref),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'HYNAPSE PROTOTYPE · NASA SPACE APPS CHALLENGE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8.5,
                        letterSpacing: 1,
                        color: Colors.white.withValues(alpha: 0.24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Wylogować operatora?'),
        content: const Text(
          'Dane pozostaną zaszyfrowane na urządzeniu i będą dostępne po '
          'ponownej autoryzacji.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Wyloguj'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref.read(sessionProvider.notifier).signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      hudRoute(const WelcomeScreen()),
      (route) => false,
    );
  }

  Widget _rowDivider() {
    return Divider(
      height: 1,
      color: Colors.white.withValues(alpha: 0.06),
      indent: 54,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Brak danych';
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(date.day)}.${two(date.month)}.${date.year} · '
        '${two(date.hour)}:${two(date.minute)}';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      radius: 18,
      child: Column(
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Bungee',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1,
              color: color,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 0.7,
              color: Colors.white.withValues(alpha: 0.40),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
    this.accent,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: accent ?? Colors.white.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 10,
                    color: accent ?? Colors.white.withValues(alpha: 0.42),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
