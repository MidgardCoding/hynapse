import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cognitive_test_result_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import 'reaction_test_screen.dart';
import 'stroop_test_screen.dart';

class CognitiveHubScreen extends ConsumerWidget {
  const CognitiveHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(cognitiveHistoryProvider);
    final summary = ref.watch(todaySummaryProvider).valueOrNull;

    return HudScaffold(
      title: 'Testy poznawcze',
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 34),
        child: ContentWidth(
          maxWidth: 620,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14),
              GlassCard(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.cyan.withValues(alpha: 0.28),
                            AppColors.cyan.withValues(alpha: 0.04),
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Icon(
                        Icons.psychology_alt_rounded,
                        color: AppColors.cyan,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SPRAWNOŚĆ POZNAWCZA',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 19, letterSpacing: 0.8),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            summary != null &&
                                    summary.stroopDone &&
                                    summary.reactionDone
                                ? 'Wszystkie testy dnia ukończone.'
                                : 'Wykonaj dwa testy, aby zamknąć dzisiejszy profil.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _CompletionRing(
                      completed: [
                        summary?.stroopDone ?? false,
                        summary?.reactionDone ?? false,
                      ].where((done) => done).length,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Wybierz test'),
              _TestCard(
                icon: Icons.tonality_rounded,
                title: 'Test Stroopa',
                label: 'KONTROLA POZNAWCZA',
                description:
                    'Nazwij kolor czcionki, ignorując treść słowa. Mierzymy czas reakcji i liczbę błędów.',
                duration: '30 s',
                accent: AppColors.cyan,
                completed: summary?.stroopDone ?? false,
                onTap: () {
                  Navigator.of(context).push(hudRoute(const StroopTestScreen()));
                },
              ),
              const SizedBox(height: 12),
              _TestCard(
                icon: Icons.bolt_rounded,
                title: 'Czas reakcji',
                label: 'SZYBKOŚĆ PSYCHOMOTORYCZNA',
                description:
                    'Kliknij, gdy sygnał zmieni kolor na zielony. Unikaj reakcji przed bodźcem.',
                duration: '30 s',
                accent: AppColors.amber,
                completed: summary?.reactionDone ?? false,
                onTap: () {
                  Navigator.of(context).push(hudRoute(const ReactionTestScreen()));
                },
              ),
              const SizedBox(height: 28),
              const SectionTitle(title: 'Ostatnie wyniki'),
              history.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                error: (_, _) => Text(
                  'Nie udało się odczytać historii.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                ),
                data: (results) {
                  if (results.isEmpty) {
                    return GlassCard(
                      child: Text(
                        'Brak wyników. Ukończ pierwszy test, aby zapisać go w lokalnej bazie Isar.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (var i = 0; i < results.length.clamp(0, 6); i++) ...[
                        _HistoryTile(result: results[i]),
                        if (i < results.length.clamp(0, 6) - 1)
                          const SizedBox(height: 8),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
              Text(
                'Wyniki są zapisywane wyłącznie na tym urządzeniu. Po synchronizacji '
                'trafiają do profilu operatora.',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.5,
                  color: Colors.white.withValues(alpha: 0.34),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionRing extends StatelessWidget {
  const _CompletionRing({required this.completed});

  final int completed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: completed / 2,
            strokeWidth: 3.4,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation(
              completed == 2 ? AppColors.green : AppColors.cyan,
            ),
          ),
          Center(
            child: Text(
              '$completed/2',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  const _TestCard({
    required this.icon,
    required this.title,
    required this.label,
    required this.description,
    required this.duration,
    required this.accent,
    required this.completed,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String label;
  final String description;
  final String duration;
  final Color accent;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      radius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.18),
                  accent.withValues(alpha: 0.02),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accent.withValues(alpha: 0.28)),
                  ),
                  child: Icon(icon, color: accent, size: 25),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 8.5,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                          color: accent.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 23,
                              letterSpacing: 0.2,
                            ),
                      ),
                    ],
                  ),
                ),
                if (completed)
                  const StatusPill(
                    label: 'Ukończony',
                    color: AppColors.green,
                    compact: true,
                  )
                else
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      duration,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.64),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      completed ? 'POWTÓRZ TEST' : 'ROZPOCZNIJ TEST',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                        color: accent,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.result});

  final CognitiveTestResultCollection result;

  @override
  Widget build(BuildContext context) {
    final isStroop = result.testType == 'stroop';
    final accent = isStroop ? AppColors.cyan : AppColors.amber;
    final date = result.timestamp;
    final label =
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}'
        ' · ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(
            isStroop ? Icons.tonality_rounded : Icons.bolt_rounded,
            color: accent,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.testLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9.5,
                    color: Colors.white.withValues(alpha: 0.38),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${result.correctCount} / ${result.correctCount + result.incorrectCount}',
                style: TextStyle(
                  fontFamily: 'Bungee',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: accent,
                ),
              ),
              Text(
                '${result.averageReactionTimeMs.round()} ms',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
