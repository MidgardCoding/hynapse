import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cognitive_test_result_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_line_chart.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';

class CognitiveResultScreen extends ConsumerWidget {
  const CognitiveResultScreen({
    super.key,
    required this.testType,
    required this.correctCount,
    required this.incorrectCount,
    required this.averageReactionTimeMs,
    required this.timestamp,
  });

  final String testType;
  final int correctCount;
  final int incorrectCount;
  final double averageReactionTimeMs;
  final DateTime timestamp;

  bool get _isStroop => testType == 'stroop';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(
      _isStroop ? stroopHistoryProvider : reactionHistoryProvider,
    );
    final label = _isStroop ? 'Stroop' : 'Czas reakcji';

    return HudScaffold(
      title: 'Wyniki testu poznawczego',
      accent: AppColors.green,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 28),
        child: ContentWidth(
          maxWidth: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StatusPill(
                    label: 'Wynik zapisany',
                    color: AppColors.green,
                    icon: Icons.cloud_done_outlined,
                    compact: true,
                  ),
                  const SizedBox(width: 8),
                  StatusPill(
                    label: label,
                    color: AppColors.cyan,
                    compact: true,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                correctCount >= 10 ? 'Świetna robota!' : 'Trening zakończony',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 38,
                      letterSpacing: -0.4,
                    ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7ED957),
                      Color(0xFF5BC94C),
                      Color(0xFFB8EA6D),
                    ],
                    stops: [0, 0.52, 1],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7ED957).withValues(alpha: 0.30),
                      blurRadius: 36,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.40),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 54,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$correctCount',
                              style: const TextStyle(
                                fontFamily: 'Bungee',
                                fontWeight: FontWeight.w700,
                                fontSize: 82,
                                height: 0.8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'POPRAWNYCH ODPOWIEDZI',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withValues(alpha: 0.88),
                            ),
                          ),
                          Text(
                            'oraz $incorrectCount błędnych',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.82),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _MetricTile(
                      label: 'Celność',
                      value:
                          '${((correctCount / (correctCount + incorrectCount).clamp(1, 999)) * 100).round()}%',
                      color: AppColors.green,
                      icon: Icons.track_changes_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MetricTile(
                      label: 'Średni czas',
                      value: averageReactionTimeMs > 0
                          ? '${averageReactionTimeMs.round()} ms'
                          : '—',
                      color: AppColors.cyan,
                      icon: Icons.speed_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              SectionTitle(title: 'Porównanie sesji'),
              history.when(
                loading: () => const GlassCard(
                  child: SizedBox(
                    height: 130,
                    child: Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                ),
                error: (_, _) => const GlassCard(
                  child: Text(
                    'Historia sesji jest chwilowo niedostępna.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ),
                data: (results) {
                  final previous = results
                      .where((r) => r.timestamp.isBefore(timestamp))
                      .cast<CognitiveTestResultCollection?>()
                      .firstWhere((r) => r != null, orElse: () => null);
                  final comparison = _comparisonText(previous);
                  return GlassCard(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          comparison,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.45,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _SessionChart(
                          results: results,
                          current: CognitiveTestResultCollection()
                            ..testType = testType
                            ..correctCount = correctCount
                            ..incorrectCount = incorrectCount
                            ..averageReactionTimeMs = averageReactionTimeMs
                            ..timestamp = timestamp,
                          isStroop: _isStroop,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 26),
              HudButton(
                label: 'Kontynuuj',
                icon: Icons.arrow_forward_rounded,
                color: AppColors.green,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 12),
              Text(
                'Wynik zapisano w lokalnej bazie Isar i dołączono do profilu operatora.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.34),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _comparisonText(CognitiveTestResultCollection? previous) {
    if (previous == null) {
      return 'Pierwsza sesja tego testu. Punkt odniesienia został zapisany.';
    }

    final double change;
    if (_isStroop) {
      final base = previous.correctCount == 0 ? 1 : previous.correctCount;
      change = ((correctCount - previous.correctCount) / base) * 100;
    } else {
      final previousAverage = previous.averageReactionTimeMs == 0
          ? 1
          : previous.averageReactionTimeMs;
      change = ((previousAverage - averageReactionTimeMs) / previousAverage) * 100;
    }

    if (change >= 0) {
      return 'Twoje wyniki są lepsze o ${change.round()}% względem poprzedniej sesji!';
    }
    return 'Różnica względem poprzedniej sesji: ${change.round()}%. Zalecamy krótki odpoczynek.';
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      radius: 18,
      child: Row(
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Bungee',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: color,
                    height: 1,
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
          ),
        ],
      ),
    );
  }
}

class _SessionChart extends StatelessWidget {
  const _SessionChart({
    required this.results,
    required this.current,
    required this.isStroop,
  });

  final List<CognitiveTestResultCollection> results;
  final CognitiveTestResultCollection current;
  final bool isStroop;

  @override
  Widget build(BuildContext context) {
    final combined = [...results]
      ..removeWhere((result) => result.timestamp == current.timestamp)
      ..add(current)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    final latest = combined.length > 5
        ? combined.sublist(combined.length - 5)
        : combined;

    final values = latest
        .map<double>(
          (result) => isStroop
              ? result.correctCount.toDouble()
              : result.averageReactionTimeMs,
        )
        .toList();
    final labels = latest
        .map((result) => _dayLabel(result.timestamp))
        .toList();

    return Column(
      children: [
        HudLineChart(
          values: values,
          labels: labels,
          color: AppColors.green,
          height: 155,
          minValue: isStroop ? 0 : null,
          unit: isStroop ? '' : 'ms',
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              isStroop ? 'Poprawne odpowiedzi' : 'Średni czas reakcji (ms)',
              style: TextStyle(
                fontSize: 9,
                color: Colors.white.withValues(alpha: 0.42),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _dayLabel(DateTime date) {
    const days = ['Pn', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nd'];
    return days[(date.weekday - 1).clamp(0, 6)];
  }
}
