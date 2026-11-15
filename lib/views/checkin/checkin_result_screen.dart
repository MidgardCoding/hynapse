import 'package:flutter/material.dart';

import '../../models/daily_log_collection.dart';
import '../../services/voice_analysis_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/metric_scale.dart';
import '../../widgets/section_title.dart';

class CheckinResultScreen extends StatelessWidget {
  const CheckinResultScreen({
    super.key,
    required this.analysis,
    required this.log,
  });

  final VoiceAnalysisResult analysis;
  final DailyLogCollection log;

  @override
  Widget build(BuildContext context) {
    return HudScaffold(
      title: 'Codzienny przegląd',
      accent: AppColors.green,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 28),
        child: ContentWidth(
          maxWidth: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'DOBRA ROBOTA!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 38,
                      letterSpacing: 0.2,
                    ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0D9FB7),
                      Color(0xFF18CFD5),
                      Color(0xFF6BE4E4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(44),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.25),
                      blurRadius: 36,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: MediaQuery.sizeOf(context).width * 0.25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: MediaQuery.sizeOf(context).width * 0.22,
                      color: Colors.white.withValues(alpha: 0.24),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${analysis.readiness}',
                                    style: const TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 76,
                                      fontWeight: FontWeight.w700,
                                      height: 0.80,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    ' / 6',
                                    style: TextStyle(
                                      fontFamily: 'Bungee',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withValues(alpha: 0.80),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'ŚREDNI WYNIK',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const StatusPill(
                    label: 'Zapisano lokalnie',
                    color: AppColors.green,
                    icon: Icons.save_outlined,
                    compact: true,
                  ),
                  const SizedBox(width: 8),
                  StatusPill(
                    label: log.timestampLabel,
                    color: AppColors.cyan,
                    compact: true,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                analysis.recommendationTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                analysis.recommendation,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.73),
                      height: 1.55,
                    ),
              ),
              const SizedBox(height: 24),
              SectionTitle(title: 'Wskaźniki dnia'),
              GlassCard(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                child: Column(
                  children: [
                    MetricScale(
                      label: 'Przemęczenie',
                      value: analysis.fatigue,
                      color: AppColors.amber,
                      icon: Icons.battery_2_bar_rounded,
                      inverse: true,
                    ),
                    const SizedBox(height: 14),
                    MetricScale(
                      label: 'Niewyspanie',
                      value: analysis.sleepDeprivation,
                      color: AppColors.cyan,
                      icon: Icons.bedtime_outlined,
                      inverse: true,
                    ),
                    const SizedBox(height: 14),
                    MetricScale(
                      label: 'Stres',
                      value: analysis.stress,
                      color: AppColors.danger,
                      icon: Icons.bolt_rounded,
                      inverse: true,
                    ),
                    const SizedBox(height: 14),
                    MetricScale(
                      label: 'Klarowność mowy',
                      value: analysis.speechClarity,
                      color: AppColors.green,
                      icon: Icons.graphic_eq_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GlassCard(
                padding: const EdgeInsets.all(18),
                color: AppColors.cyan.withValues(alpha: 0.06),
                borderColor: AppColors.cyan.withValues(alpha: 0.18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cyan.withValues(alpha: 0.12),
                      ),
                      child: const Icon(
                        Icons.medical_services_outlined,
                        size: 19,
                        color: AppColors.cyan,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ZALECENIE MEDYCZNE · NASA-TLX',
                            style: TextStyle(
                              fontSize: 8.5,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700,
                              color: AppColors.cyan.withValues(alpha: 0.9),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            analysis.needsRecovery
                                ? 'Ogranicz zadania wymagające wysokiej czujności do '
                                    'momentu regeneracji. Zaplanuj 20-minutową przerwę '
                                    'i powtórz test Stroopa.'
                                : 'Parametry pozostają w zakresie operacyjnym. Utrzymaj '
                                    'nawodnienie i wykonaj zaplanowane testy.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GlassCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.format_quote_rounded,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'TRANSKRYPCJA PRÓBKI GŁOSU',
                          style: TextStyle(
                            fontSize: 8.5,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '„${analysis.transcript}”',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.55,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              HudButton(
                label: 'Kontynuuj',
                icon: Icons.arrow_forward_rounded,
                color: AppColors.green,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 10),
              Text(
                'Check-in zapisany w Isar. Dane nie opuszczają urządzenia bez '
                'autoryzowanej synchronizacji.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9.5,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
