import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/voice_waveform.dart';
import 'checkin_recording_screen.dart';

class CheckinIntroScreen extends StatelessWidget {
  const CheckinIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HudScaffold(
      title: 'Codzienny przegląd',
      body: LayoutBuilder(
        builder: (context, constraints) {
          final orbSize = (constraints.maxWidth * 0.62).clamp(210.0, 280.0);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          'KLIKNIJ I ZACZNIJ MÓWIĆ',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 27,
                                    letterSpacing: 0.4,
                                  ),
                        ),
                        const SizedBox(height: 22),
                        GestureDetector(
                          onTap: () => _start(context),
                          child: WaveformOrb(
                            active: false,
                            diameter: orbSize,
                            child: Center(
                              child: Container(
                                width: orbSize * 0.38,
                                height: orbSize * 0.38,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF555560).withValues(alpha: 0.9),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.mic_rounded,
                                  size: orbSize * 0.18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'DOTKNIJ MIKROFONU, ABY ROZPOCZĄĆ',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: AppColors.cyan.withValues(alpha: 0.72),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          'Opowiedz o swoim poprzednim dniu',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Twoje nagranie zostanie przeanalizowane pod kątem '
                          'obecności stresu, wahań emocjonalnych, kłopotów z wymową '
                          'i innych problemów, zgodnie z wytycznymi NASA i naukowców.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.72),
                                height: 1.55,
                              ),
                        ),
                        const SizedBox(height: 22),
                        GlassCard(
                          padding: const EdgeInsets.fromLTRB(16, 15, 16, 13),
                          radius: 20,
                          child: Column(
                            children: [
                              Text(
                                'Nasz zaawansowany algorytm przeanalizuje Twój głos '
                                'i określi poziom następujących statystyk:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  height: 1.45,
                                  color: Colors.white.withValues(alpha: 0.54),
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _AnalysisMetric(
                                    icon: Icons.battery_2_bar_rounded,
                                    label: 'Przemęczenie',
                                    color: AppColors.amber,
                                  ),
                                  _AnalysisMetric(
                                    icon: Icons.bedtime_outlined,
                                    label: 'Niewyspanie',
                                    color: AppColors.cyan,
                                  ),
                                  _AnalysisMetric(
                                    icon: Icons.bolt_rounded,
                                    label: 'Stres',
                                    color: AppColors.danger,
                                  ),
                                  _AnalysisMetric(
                                    icon: Icons.graphic_eq_rounded,
                                    label: 'Mowa',
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        HudButton(
                          label: 'Rozpocznij przegląd',
                          icon: Icons.mic_none_rounded,
                          onPressed: () => _start(context),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tryb demonstracyjny · analiza symulowana lokalnie',
                          style: TextStyle(
                            fontSize: 9,
                            letterSpacing: 0.3,
                            color: Colors.white.withValues(alpha: 0.30),
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

  void _start(BuildContext context) {
    Navigator.of(context).pushReplacement(
      hudRoute(const CheckinRecordingScreen()),
    );
  }
}

class _AnalysisMetric extends StatelessWidget {
  const _AnalysisMetric({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: Colors.white.withValues(alpha: 0.82)),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.5,
              color: Colors.white.withValues(alpha: 0.50),
            ),
          ),
        ],
      ),
    );
  }
}
