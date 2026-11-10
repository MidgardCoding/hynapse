import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/activity_dial.dart';
import '../../models/daily_log_collection.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/metric_scale.dart';
import '../../widgets/section_title.dart';
import '../../widgets/task_card.dart';
import '../checkin/checkin_intro_screen.dart';
import '../cognitive/cognitive_hub_screen.dart';
import '../cognitive/reaction_test_screen.dart';
import '../cognitive/stroop_test_screen.dart';
import '../welcome/welcome_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({
    super.key,
    required this.onOpenSettings,
    required this.onOpenEmergency,
  });

  final VoidCallback onOpenSettings;
  final VoidCallback onOpenEmergency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final summary = ref.watch(todaySummaryProvider);
    final name = session.valueOrNull?.displayName ?? 'Rafał';
    final data = summary.valueOrNull;
    final pending = 3 - (data?.completedTasks ?? 0);
    final now = DateTime.now();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          HudAppBar(
            title: 'Strona główna',
            leading: HudLeading.menu,
            onLeadingTap: () => _showMenu(context, ref),
            actions: [
              HudMenuAction(
                icon: Icons.notifications_none_rounded,
                tooltip: 'Powiadomienia',
                onTap: () => _showBriefing(context, data),
              ),
            ],
          ),
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
                    _StatusStrip(now: now),
                    const SizedBox(height: 22),
                    _Greeting(name: name),
                    const SizedBox(height: 16),
                    GlassCard(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      child: Text(
                        'Dzień 184 na orbicie. Twoje parametry poznawcze są stabilne. '
                        'Wykonaj dzienny przegląd i zaplanowane testy, aby utrzymać '
                        'gotowość operacyjną zespołu.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.80),
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _DialSection(
                      readiness: data?.readiness ?? 3,
                      completed: data?.completedTasks ?? 0,
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            Navigator.of(
                              context,
                            ).push(hudRoute(const CheckinIntroScreen()));
                          case 1:
                            Navigator.of(
                              context,
                            ).push(hudRoute(const CognitiveHubScreen()));
                          case 2:
                            _openHealth(context, data);
                          case 3:
                            _showComms(context);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    SectionTitle(
                      title: 'Zadania na dzisiaj',
                      trailing: _TaskCounter(
                        completed: data?.completedTasks ?? 0,
                        total: 3,
                      ),
                    ),
                    if (summary.isLoading)
                      const _TasksLoading()
                    else ...[
                      TaskCard(
                        number: 1,
                        title: 'Przegląd dzienny',
                        description:
                            '10-sekundowy check-in głosowy. Analiza zmęczenia, snu i stresu.',
                        priority: TaskPriority.high,
                        accent: AppColors.green,
                        completed: data?.hasDailyLogToday ?? false,
                        onTap: () {
                          Navigator.of(
                            context,
                          ).push(hudRoute(const CheckinIntroScreen()));
                        },
                      ),
                      const SizedBox(height: 12),
                      TaskCard(
                        number: 2,
                        title: 'Test Stroopa',
                        description:
                            '30 sekund. Zmierz kontrolę poznawczą i odporność na dystrakcję.',
                        priority: TaskPriority.medium,
                        accent: AppColors.amber,
                        completed: data?.stroopDone ?? false,
                        onTap: () {
                          Navigator.of(
                            context,
                          ).push(hudRoute(const StroopTestScreen()));
                        },
                      ),
                      const SizedBox(height: 12),
                      TaskCard(
                        number: 3,
                        title: 'Czas reakcji',
                        description:
                            '30 sekund. Sprawdź szybkość reakcji psychomotorycznej.',
                        priority: TaskPriority.low,
                        accent: AppColors.cyan,
                        completed: data?.reactionDone ?? false,
                        onTap: () {
                          Navigator.of(
                            context,
                          ).push(hudRoute(const ReactionTestScreen()));
                        },
                      ),
                    ],
                    const SizedBox(height: 26),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        const StatusPill(
                          label: 'Stacja nominalna',
                          icon: Icons.check_circle_outline_rounded,
                          color: AppColors.green,
                          compact: true,
                        ),
                        StatusPill(
                          label: '$pending zadań otwartych',
                          icon: Icons.bolt_rounded,
                          color: pending == 0
                              ? AppColors.green
                              : AppColors.amber,
                          compact: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Ostatnia synchronizacja: dziś, 06:42 UTC · Isar Local Engine',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        letterSpacing: 0.2,
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

  void _openHealth(BuildContext context, TodaySummary? data) {
    if (data?.dailyLog == null) {
      Navigator.of(context).push(hudRoute(const CheckinIntroScreen()));
    } else {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          final log = data!.dailyLog!;
          return _HealthSheet(log: log);
        },
      );
    }
  }

  void _showComms(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CommsSheet(),
    );
  }

  void _showBriefing(BuildContext context, TodaySummary? data) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Powiadomienia'),
        content: Text(
          data?.completedTasks == 3
              ? 'Wszystkie zadania dnia zostały wykonane. Wyniki zapisano lokalnie.'
              : 'Masz ${3 - (data?.completedTasks ?? 0)} otwarte zadania. '
                    'Priorytetem jest dzienny przegląd głosowy.',
          style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zamknij'),
          ),
        ],
      ),
    );
  }

  Future<void> _showMenu(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _DashboardMenu(
          onCheckin: () {
            Navigator.pop(context);
            Navigator.of(context).push(hudRoute(const CheckinIntroScreen()));
          },
          onTests: () {
            Navigator.pop(context);
            Navigator.of(context).push(hudRoute(const CognitiveHubScreen()));
          },
          onEmergency: () {
            Navigator.pop(context);
            onOpenEmergency();
          },
          onSettings: () {
            Navigator.pop(context);
            onOpenSettings();
          },
          onLogout: () async {
            Navigator.pop(context);
            await ref.read(sessionProvider.notifier).signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              hudRoute(const WelcomeScreen()),
              (route) => false,
            );
          },
        );
      },
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'WITAJ, ${name.toUpperCase()}!',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 34,
              letterSpacing: -0.2,
            ),
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.amber.withValues(alpha: 0.22),
                Colors.transparent,
              ],
            ),
          ),
          child: const Icon(
            Icons.wb_sunny_rounded,
            color: AppColors.amber,
            size: 28,
          ),
        ),
      ],
    );
  }
}

class _StatusStrip extends StatelessWidget {
  const _StatusStrip({required this.now});

  final DateTime now;

  static const _days = [
    'PONIEDZIAŁEK',
    'WTOREK',
    'ŚRODA',
    'CZWARTEK',
    'PIĄTEK',
    'SOBOTA',
    'NIEDZIELA',
  ];

  @override
  Widget build(BuildContext context) {
    final day = _days[(now.weekday - 1).clamp(0, 6)];
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cyan,
            boxShadow: [
              BoxShadow(
                color: AppColors.cyan.withValues(alpha: 0.8),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$day · ${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.9,
              color: Colors.white.withValues(alpha: 0.50),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const StatusPill(
          label: 'LEO · 408 km',
          color: AppColors.cyan,
          compact: true,
        ),
      ],
    );
  }
}

class _DialSection extends StatelessWidget {
  const _DialSection({
    required this.readiness,
    required this.completed,
    required this.onTap,
  });

  final int readiness;
  final int completed;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dialSize = (constraints.maxWidth * 0.78).clamp(220.0, 310.0);
        return Column(
          children: [
            SizedBox(
              width: dialSize,
              height: dialSize,
              child: ActivityDial(
                readiness: readiness,
                completedSegments: completed,
                onSegmentTap: onTap,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kliknij segment, by przejść do modułu',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.52),
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TaskCounter extends StatelessWidget {
  const _TaskCounter({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final allDone = completed >= total;
    return Container(
      width: 35,
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.22),
        border: Border.all(
          color: (allDone ? AppColors.green : AppColors.cyan).withValues(
            alpha: 0.45,
          ),
        ),
      ),
      child: Text(
        allDone ? '✓' : '${total - completed}',
        style: TextStyle(
          fontSize: allDone ? 15 : 16,
          fontWeight: FontWeight.w700,
          color: allDone ? AppColors.green : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _TasksLoading extends StatelessWidget {
  const _TasksLoading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 3; i++) ...[
          Container(
            height: 112,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
          ),
          if (i < 2) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _HealthSheet extends StatelessWidget {
  const _HealthSheet({required this.log});

  final DailyLogCollection log;

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Status zdrowia',
      accent: AppColors.green,
      children: [
        Row(
          children: [
            _SheetMetric(label: 'Gotowość', value: '${log.readiness}/6'),
            _SheetMetric(label: 'Zmęczenie', value: '${log.fatigue}/6'),
            _SheetMetric(label: 'Stres', value: '${log.stress}/6'),
            _SheetMetric(label: 'Sen', value: '${log.sleepDeprivation}/6'),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Ostatni przegląd: ${log.timestampLabel}',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _CommsSheet extends StatelessWidget {
  const _CommsSheet();

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Łączność',
      accent: AppColors.cyan,
      children: [
        const Row(
          children: [
            Icon(Icons.satellite_alt_rounded, color: AppColors.cyan, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Kanał telemetrii S-BAND · stabilny',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            StatusPill(label: 'Online', color: AppColors.green),
          ],
        ),
        const SizedBox(height: 20),
        const LabeledProgress(
          label: 'Siła sygnału',
          value: 0.86,
          color: AppColors.cyan,
          trailing: '86%',
        ),
        const SizedBox(height: 12),
        const LabeledProgress(
          label: 'Opóźnienie',
          value: 0.18,
          color: AppColors.green,
          trailing: '412 ms',
        ),
      ],
    );
  }
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({
    required this.title,
    required this.children,
    this.accent = AppColors.cyan,
  });

  final String title;
  final List<Widget> children;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        22,
        14,
        22,
        22 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF11152A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(width: 3, height: 18, color: accent),
              const SizedBox(width: 9),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _SheetMetric extends StatelessWidget {
  const _SheetMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Bungee',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 0.7,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardMenu extends StatelessWidget {
  const _DashboardMenu({
    required this.onCheckin,
    required this.onTests,
    required this.onEmergency,
    required this.onSettings,
    required this.onLogout,
  });

  final VoidCallback onCheckin;
  final VoidCallback onTests;
  final VoidCallback onEmergency;
  final VoidCallback onSettings;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.mic_none_rounded, 'Dzienny przegląd', AppColors.green, onCheckin),
      (
        Icons.psychology_alt_rounded,
        'Testy poznawcze',
        AppColors.cyan,
        onTests,
      ),
      (
        Icons.warning_amber_rounded,
        'Tryb awaryjny',
        AppColors.danger,
        onEmergency,
      ),
      (
        Icons.settings_rounded,
        'Ustawienia',
        AppColors.textSecondary,
        onSettings,
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        22 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF10142A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'NAWIGACJA',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textMuted,
              fontSize: 13,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          for (final item in items)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 2),
              leading: Icon(item.$1, color: item.$3, size: 22),
              title: Text(item.$2),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              onTap: item.$4,
            ),
          const Divider(color: Colors.white12),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            leading: const Icon(
              Icons.logout_rounded,
              color: AppColors.danger,
              size: 22,
            ),
            title: const Text('Wyloguj'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
