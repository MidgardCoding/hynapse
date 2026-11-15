import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cognitive_test_result_collection.dart';
import '../../providers/app_providers.dart';
import '../../services/seed_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import 'cognitive_result_screen.dart';

class StroopTestScreen extends ConsumerStatefulWidget {
  const StroopTestScreen({super.key});

  @override
  ConsumerState<StroopTestScreen> createState() => _StroopTestScreenState();
}

class _StroopTestScreenState extends ConsumerState<StroopTestScreen> {
  static const _colors = [
    _StroopColor('Czerwony', Color(0xFFFF3B30)),
    _StroopColor('Niebieski', Color(0xFF32ADE6)),
    _StroopColor('Zielony', Color(0xFF34C759)),
    _StroopColor('Czarny', Color(0xFF111111)),
    _StroopColor('Żółty', Color(0xFFFFD60A)),
  ];

  final _random = Random();
  late Timer _timer;
  final _reactionTimes = <int>[];
  final _stopwatch = Stopwatch();
  int _remaining = 30;
  int _correct = 0;
  int _incorrect = 0;
  int _wordIndex = 0;
  int _inkIndex = 1;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    _newPrompt();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _finishing) return;
      if (_remaining <= 1) {
        timer.cancel();
        _finish();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _newPrompt() {
    _wordIndex = _random.nextInt(_colors.length);
    _inkIndex = _random.nextInt(_colors.length);
    if (_inkIndex == _wordIndex) {
      _inkIndex =
          (_inkIndex + 1 + _random.nextInt(_colors.length - 1)) %
          _colors.length;
    }
    _stopwatch
      ..reset()
      ..start();
  }

  void _answer(int index) {
    if (_finishing) return;
    final elapsed = _stopwatch.elapsedMilliseconds.clamp(80, 8000);
    _reactionTimes.add(elapsed);
    setState(() {
      if (index == _inkIndex) {
        _correct++;
      } else {
        _incorrect++;
      }
      _newPrompt();
    });
  }

  Future<void> _finish() async {
    if (_finishing) return;
    setState(() => _finishing = true);
    _timer.cancel();
    _stopwatch.stop();

    final average = _reactionTimes.isEmpty
        ? 0.0
        : _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length;
    final session = ref.read(sessionProvider).valueOrNull;
    final result = CognitiveTestResultCollection()
      ..userId = session?.userId ?? SeedService.prototypeUserId
      ..testType = 'stroop'
      ..correctCount = _correct
      ..incorrectCount = _incorrect
      ..averageReactionTimeMs = average
      ..timestamp = DateTime.now();

    try {
      await ref.read(repositoryProvider).saveCognitiveResult(result);
      ref.invalidate(todaySummaryProvider);
      ref.invalidate(cognitiveHistoryProvider);
      ref.invalidate(stroopHistoryProvider);
      ref.invalidate(profileStatsProvider);
    } catch (_) {
      // Wynik nadal prezentujemy, nawet jeśli zapis lokalny chwilowo zawiedzie.
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      hudRoute(
        CognitiveResultScreen(
          testType: 'stroop',
          correctCount: _correct,
          incorrectCount: _incorrect,
          averageReactionTimeMs: average,
          timestamp: result.timestamp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ink = _colors[_inkIndex];

    return HudScaffold(
      title: 'Test poznawczy Stroopa',
      actions: [
        StatusPill(
          label: '${_remaining}s',
          color: _remaining <= 5 ? AppColors.danger : AppColors.cyan,
          icon: Icons.timer_outlined,
        ),
        const SizedBox(width: 4),
      ],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 97, 93, 107),
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.32),
                                blurRadius: 30,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 155,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      _colors[_wordIndex].name,
                                      style: TextStyle(
                                        fontFamily: 'SansExpanded',
                                        fontSize: 60,
                                        fontWeight: FontWeight.w700,
                                        color: ink.color,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                  14,
                                  20,
                                  14,
                                  16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    118,
                                    114,
                                    127,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, choiceConstraints) {
                                    final diameter =
                                        ((choiceConstraints.maxWidth - 48) / 3)
                                            .clamp(56.0, 84.0);
                                    return Column(
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 18,
                                          runSpacing: 18,
                                          children: [
                                            for (var i = 0; i < 3; i++)
                                              _ColorChoice(
                                                color: _colors[i],
                                                diameter: diameter,
                                                onTap: () => _answer(i),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 18),
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 18,
                                          runSpacing: 18,
                                          children: [
                                            for (var i = 3; i < 5; i++)
                                              _ColorChoice(
                                                color: _colors[i],
                                                diameter: diameter,
                                                onTap: () => _answer(i),
                                              ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Text(
                                    'Poprawne: $_correct',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 217, 209, 255),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Błędne: $_incorrect',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 214, 175),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 26),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 19,
                              color: Colors.white.withValues(alpha: 0.54),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Kliknij kolor odpowiadający kolorowi czcionki tekstu '
                                'znajdującego się powyżej.',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.45,
                                  color: Colors.white.withValues(alpha: 0.60),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _finishing
                              ? 'Zapisywanie wyniku...'
                              : 'Koniec za $_remaining sekund',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                        ),
                        if (_finishing) ...[
                          const SizedBox(height: 10),
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StroopColor {
  const _StroopColor(this.name, this.color);

  final String name;
  final Color color;
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({
    required this.color,
    required this.diameter,
    required this.onTap,
  });

  final _StroopColor color;
  final double diameter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: color.name,
      child: Tooltip(
        message: color.name,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Ink(
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                color: color.color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.24),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
