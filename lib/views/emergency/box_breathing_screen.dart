import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_scaffold.dart';

class BoxBreathingScreen extends StatefulWidget {
  const BoxBreathingScreen({super.key});

  @override
  State<BoxBreathingScreen> createState() => _BoxBreathingScreenState();
}

class _BoxBreathingScreenState extends State<BoxBreathingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _phaseNames = ['Wdech', 'Zatrzymaj', 'Wydech', 'Wstrzymaj'];
  static const _phaseHints = [
    'Wciągnij powietrze nosem',
    'Zatrzymaj oddech',
    'Wypuść powietrze ustami',
    'Pozostań bez ruchu',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HudScaffold(
      title: 'Atak paniki · Box Breathing',
      danger: true,
      accent: AppColors.cyan,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final diameter = (constraints.maxWidth * 0.68).clamp(220.0, 300.0);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        StatusPill(
                          label: 'Technika 4-4-4-4',
                          color: AppColors.cyan,
                          icon: Icons.air_rounded,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'ODDYCHAJ W RYTMIE KRĘGU',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 26,
                                letterSpacing: 0.5,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Podążaj za animacją. Cztery fazy po cztery sekundy '
                          'przywrócą kontrolę nad oddechem.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.5,
                            color: Colors.white.withValues(alpha: 0.56),
                          ),
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: diameter + 38,
                          height: diameter + 38,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              final t = _controller.value;
                              final phase = (t * 4).floor().clamp(0, 3);
                              final within = (t * 4) - phase;
                              final countdown = (4 - (within * 4).floor()).clamp(1, 4);

                              final double scale;
                              if (phase == 0) {
                                scale = 0.64 +
                                    Curves.easeInOut.transform(within) * 0.36;
                              } else if (phase == 1) {
                                scale = 1;
                              } else if (phase == 2) {
                                scale = 1 -
                                    Curves.easeInOut.transform(within) * 0.36;
                              } else {
                                scale = 0.64;
                              }

                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Transform.scale(
                                    scale: 0.88 + (scale * 0.18),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.cyan
                                              .withValues(alpha: 0.12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      width: diameter,
                                      height: diameter,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          center: const Alignment(-0.3, -0.4),
                                          colors: [
                                            AppColors.cyan.withValues(alpha: 0.46),
                                            const Color(0xFF0D7F91)
                                                .withValues(alpha: 0.35),
                                            AppColors.cyan.withValues(alpha: 0.06),
                                            Colors.transparent,
                                          ],
                                          stops: const [0, 0.45, 0.78, 1],
                                        ),
                                        border: Border.all(
                                          color: AppColors.cyan
                                              .withValues(alpha: 0.42),
                                          width: 1.4,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.cyan
                                                .withValues(alpha: 0.20),
                                            blurRadius: 50,
                                            spreadRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _phaseNames[phase].toUpperCase(),
                                              style: const TextStyle(
                                                fontFamily: 'Bungee',
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1.2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '$countdown',
                                              style: const TextStyle(
                                                fontFamily: 'Bungee',
                                                fontSize: 50,
                                                height: 0.9,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              _phaseHints[phase],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 9.5,
                                                color: Colors.white
                                                    .withValues(alpha: 0.62),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        _PhaseTrack(controller: _controller),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.psychology_alt_outlined,
                                color: AppColors.cyan,
                                size: 20,
                              ),
                              const SizedBox(width: 11),
                              Expanded(
                                child: Text(
                                  'Jeżeli zawroty głowy nie ustępują, przerwij ćwiczenie '
                                  'i zgłoś objawy personelowi medycznemu misji.',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    height: 1.45,
                                    color: Colors.white.withValues(alpha: 0.55),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        HudButton(
                          label: 'Zakończ ćwiczenie',
                          icon: Icons.close_rounded,
                          style: HudButtonStyle.outline,
                          onPressed: () => Navigator.of(context).pop(),
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

class _PhaseTrack extends StatelessWidget {
  const _PhaseTrack({required this.controller});

  final AnimationController controller;

  static const _names = ['Wdech', 'Zatrzymaj', 'Wydech', 'Wstrzymaj'];
  static const _times = ['4s', '4s', '4s', '4s'];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final active = (controller.value * 4).floor().clamp(0, 3);
        return Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: i == active
                        ? AppColors.cyan.withValues(alpha: 0.14)
                        : Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: i == active
                          ? AppColors.cyan.withValues(alpha: 0.35)
                          : Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _names[i].toUpperCase(),
                        style: TextStyle(
                          fontSize: 7.5,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w700,
                          color: i == active
                              ? AppColors.cyan
                              : Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _times[i],
                        style: TextStyle(
                          fontFamily: 'Bungee',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: i == active
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
