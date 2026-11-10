import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/daily_log_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/voice_waveform.dart';
import 'checkin_result_screen.dart';

class CheckinRecordingScreen extends ConsumerStatefulWidget {
  const CheckinRecordingScreen({super.key});

  @override
  ConsumerState<CheckinRecordingScreen> createState() =>
      _CheckinRecordingScreenState();
}

class _CheckinRecordingScreenState extends ConsumerState<CheckinRecordingScreen> {
  static const _recordingDuration = Duration(seconds: 10);

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _finalizing = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return;
      setState(() => _elapsed += const Duration(milliseconds: 100));
      if (_elapsed >= _recordingDuration) {
        timer.cancel();
        _finalize();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _finalize() async {
    if (_finalizing) return;
    setState(() => _finalizing = true);
    _timer?.cancel();

    await Future<void>.delayed(const Duration(milliseconds: 450));
    final session = ref.read(sessionProvider).valueOrNull;
    final analysis = ref.read(voiceAnalysisProvider).analyse(
          _elapsed,
          seed: session?.userId.hashCode ?? 7,
        );
    final log = DailyLogCollection()
      ..userId = session?.userId ?? 'offline'
      ..fatigue = analysis.fatigue
      ..sleepDeprivation = analysis.sleepDeprivation
      ..stress = analysis.stress
      ..speechClarity = analysis.speechClarity
      ..transcript = analysis.transcript
      ..readiness = analysis.readiness
      ..timestamp = DateTime.now();

    try {
      await ref.read(repositoryProvider).saveDailyLog(log);
      ref.invalidate(todaySummaryProvider);
      ref.invalidate(profileStatsProvider);
    } catch (_) {
      // Prezentujemy wynik nawet wtedy, gdy zapis lokalny jest chwilowo niedostępny.
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      hudRoute(CheckinResultScreen(analysis: analysis, log: log)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining =
        (_recordingDuration.inSeconds - _elapsed.inSeconds).clamp(0, 10);
    final progress =
        (_elapsed.inMilliseconds / _recordingDuration.inMilliseconds).clamp(0.0, 1.0);

    return HudScaffold(
      title: 'Codzienny przegląd',
      actions: [
        StatusPill(
          label: _finalizing ? 'Analiza' : 'REC',
          color: _finalizing ? AppColors.cyan : AppColors.danger,
          compact: true,
        ),
        const SizedBox(width: 4),
      ],
      body: LayoutBuilder(
        builder: (context, constraints) {
          final orbSize = (constraints.maxWidth * 0.72).clamp(230.0, 310.0);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mów spokojnie przez\nprzynajmniej 10 sekund',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 26,
                                    height: 1.2,
                                  ),
                        ),
                        const SizedBox(height: 30),
                        WaveformOrb(
                          active: !_finalizing,
                          diameter: orbSize,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                top: orbSize * 0.12,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: _RecordingPill(finalizing: _finalizing),
                                ),
                              ),
                              Positioned(
                                bottom: orbSize * 0.15,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Text(
                                    _finalizing ? '...' : '$remaining',
                                    style: const TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 34,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),
                        _SegmentedProgress(progress: progress),
                        const SizedBox(height: 18),
                        Text(
                          _finalizing
                              ? 'Analizujemy próbkę głosu...'
                              : 'Nagrywanie aktywne · pozostało $remaining s',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 0.3,
                            color: Colors.white.withValues(alpha: 0.50),
                          ),
                        ),
                        TextButton(
                          onPressed: _finalizing ? null : _finalize,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white.withValues(alpha: 0.72),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            _finalizing ? 'Proszę czekać' : 'Przerwij i analizuj',
                            style: const TextStyle(fontSize: 13),
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

class _RecordingPill extends StatelessWidget {
  const _RecordingPill({required this.finalizing});

  final bool finalizing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: finalizing ? AppColors.cyan : AppColors.danger,
              boxShadow: [
                BoxShadow(
                  color: (finalizing ? AppColors.cyan : AppColors.danger)
                      .withValues(alpha: 0.7),
                  blurRadius: 7,
                ),
              ],
            ),
          ),
          const SizedBox(width: 7),
          Text(
            finalizing ? 'ANALIZA' : 'NAGRYWANIE',
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedProgress extends StatelessWidget {
  const _SegmentedProgress({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    const segments = 10;
    return Row(
      children: [
        for (var i = 0; i < segments; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 130),
              height: 7,
              decoration: BoxDecoration(
                color: i < (progress * segments).ceil()
                    ? AppColors.cyan
                    : Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
                boxShadow: i < (progress * segments).ceil()
                    ? [
                        BoxShadow(
                          color: AppColors.cyan.withValues(alpha: 0.35),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
