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

enum _ReactionState { waiting, ready, tooSoon, scored }

class ReactionTestScreen extends ConsumerStatefulWidget {
  const ReactionTestScreen({super.key});

  @override
  ConsumerState<ReactionTestScreen> createState() => _ReactionTestScreenState();
}

class _ReactionTestScreenState extends ConsumerState<ReactionTestScreen> {
  final _random = Random();
  final _reactionTimes = <int>[];
  final _stopwatch = Stopwatch();
  late Timer _countdown;
  Timer? _stimulusTimer;
  Timer? _resetTimer;

  int _remaining = 30;
  int _correct = 0;
  int _incorrect = 0;
  int? _lastReaction;
  _ReactionState _state = _ReactionState.waiting;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    _countdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _finishing) return;
      if (_remaining <= 1) {
        timer.cancel();
        _finish();
      } else {
        setState(() => _remaining--);
      }
    });
    _scheduleStimulus();
  }

  @override
  void dispose() {
    _countdown.cancel();
    _stimulusTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _scheduleStimulus() {
    _stimulusTimer?.cancel();
    _stimulusTimer = Timer(
      Duration(milliseconds: 1300 + _random.nextInt(2300)),
      () {
        if (!mounted || _finishing) return;
        _stopwatch
          ..reset()
          ..start();
        setState(() => _state = _ReactionState.ready);
      },
    );
  }

  void _handleTap() {
    if (_finishing) return;
    switch (_state) {
      case _ReactionState.waiting:
        _incorrect++;
        _state = _ReactionState.tooSoon;
        setState(() {});
        _resetTimer?.cancel();
        _resetTimer = Timer(const Duration(milliseconds: 850), () {
          if (!mounted) return;
          setState(() => _state = _ReactionState.waiting);
          _scheduleStimulus();
        });
      case _ReactionState.ready:
        final milliseconds = _stopwatch.elapsedMilliseconds.clamp(90, 2500);
        _lastReaction = milliseconds;
        _reactionTimes.add(milliseconds);
        _correct++;
        _state = _ReactionState.scored;
        setState(() {});
        _resetTimer?.cancel();
        _resetTimer = Timer(const Duration(milliseconds: 760), () {
          if (!mounted) return;
          setState(() => _state = _ReactionState.waiting);
          _scheduleStimulus();
        });
      case _ReactionState.tooSoon:
      case _ReactionState.scored:
        break;
    }
  }

  Future<void> _finish() async {
    if (_finishing) return;
    setState(() => _finishing = true);
    _countdown.cancel();
    _stimulusTimer?.cancel();
    _resetTimer?.cancel();

    final average = _reactionTimes.isEmpty
        ? 0.0
        : _reactionTimes.reduce((a, b) => a + b) / _reactionTimes.length;
    final session = ref.read(sessionProvider).valueOrNull;
    final result = CognitiveTestResultCollection()
      ..userId = session?.userId ?? SeedService.prototypeUserId
      ..testType = 'reaction'
      ..correctCount = _correct
      ..incorrectCount = _incorrect
      ..averageReactionTimeMs = average
      ..timestamp = DateTime.now();

    try {
      await ref.read(repositoryProvider).saveCognitiveResult(result);
      ref.invalidate(todaySummaryProvider);
      ref.invalidate(cognitiveHistoryProvider);
      ref.invalidate(reactionHistoryProvider);
      ref.invalidate(profileStatsProvider);
    } catch (_) {
      // Prezentujemy wynik nawet w trybie offline.
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      hudRoute(
        CognitiveResultScreen(
          testType: 'reaction',
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
    final isReady = _state == _ReactionState.ready;
    final isError = _state == _ReactionState.tooSoon;

    final circleColor = isReady
        ? AppColors.green
        : isError
            ? const Color(0xFF7A3B3F)
            : const Color(0xFFFF5A55);
    final title = switch (_state) {
      _ReactionState.waiting => 'Poczekaj na zielony',
      _ReactionState.ready => 'TERAZ!',
      _ReactionState.tooSoon => 'Za wcześnie',
      _ReactionState.scored => '${_lastReaction ?? 0} ms',
    };
    final subtitle = switch (_state) {
      _ReactionState.waiting => 'Kliknij przycisk, gdy stanie się zielony.',
      _ReactionState.ready => 'Kliknij natychmiast!',
      _ReactionState.tooSoon => 'Odczekaj na zielony sygnał.',
      _ReactionState.scored => 'Reakcja zapisana.',
    };

    return HudScaffold(
      title: 'Test czasu reakcji',
      actions: [
        StatusPill(
          label: '${_remaining}s',
          color: _remaining <= 5 ? AppColors.danger : AppColors.amber,
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
                            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B3D45).withValues(alpha: 0.94),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.09),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  blurRadius: 32,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 140),
                                  child: Text(
                                    title,
                                    key: ValueKey(title),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontWeight: FontWeight.w700,
                                      fontSize: isReady ? 38 : 34,
                                      height: 1,
                                      color: isReady
                                          ? AppColors.green
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha: 0.72),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                GestureDetector(
                                  onTap: _handleTap,
                                  child: AnimatedScale(
                                    scale: isReady ? 1.04 : 1,
                                    duration: const Duration(milliseconds: 160),
                                    curve: Curves.easeOutBack,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 110),
                                      width: (constraints.maxWidth * 0.52)
                                          .clamp(180.0, 250.0),
                                      height: (constraints.maxWidth * 0.52)
                                          .clamp(180.0, 250.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: circleColor,
                                        border: Border.all(
                                          color: Colors.black.withValues(alpha: 0.26),
                                          width: 4,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: circleColor.withValues(alpha: 0.45),
                                            blurRadius: isReady ? 44 : 24,
                                            spreadRadius: isReady ? 8 : 0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Icon(
                                          isReady
                                              ? Icons.bolt_rounded
                                              : isError
                                                  ? Icons.close_rounded
                                                  : _state == _ReactionState.scored
                                                      ? Icons.check_rounded
                                                      : Icons.touch_app_outlined,
                                          size: 44,
                                          color: Colors.white.withValues(alpha: 0.9),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 34),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Poprawne: $_correct',
                                        style: const TextStyle(
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Błędne: $_incorrect',
                                      style: const TextStyle(
                                        color: AppColors.danger,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                                  'Kliknij pole, gdy zmieni kolor na zielony. Reakcja przed '
                                  'bodźcem zostanie zapisana jako błąd.',
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
