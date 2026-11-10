import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/emergency_protocol_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import 'emergency_detail_screen.dart';

class EmergencyCategoryScreen extends ConsumerWidget {
  const EmergencyCategoryScreen({
    super.key,
    required this.category,
    required this.title,
  });

  final String category;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protocolsAsync = ref.watch(emergencyProtocolsProvider);

    return HudScaffold(
      title: title,
      danger: true,
      accent: AppColors.danger,
      body: protocolsAsync.when(
        loading: () => const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        error: (_, _) => Center(
          child: Text(
            'Nie udało się odczytać procedur.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          ),
        ),
        data: (protocols) {
          final filtered = protocols
              .where((protocol) => protocol.category == category)
              .toList();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 28),
            child: ContentWidth(
              maxWidth: 620,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 18),
                  Text(
                    'WYBIERZ PROCEDURĘ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 25,
                          letterSpacing: 0.4,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lista działa bez dostępu do sieci. Instrukcje są zapisane w Isar.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.48),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (filtered.isEmpty)
                    GlassCard(
                      child: Text(
                        'Brak procedur w tej kategorii.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    )
                  else
                    for (var i = 0; i < filtered.length; i++) ...[
                      _ProtocolCard(
                        protocol: filtered[i],
                        onTap: () {
                          Navigator.of(context).push(
                            hudRoute(
                              EmergencyDetailScreen(protocol: filtered[i]),
                            ),
                          );
                        },
                      ),
                      if (i < filtered.length - 1) const SizedBox(height: 12),
                    ],
                  const SizedBox(height: 22),
                  const SectionTitle(title: 'Zasada eskalacji'),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.danger.withValues(alpha: 0.07),
                    borderColor: AppColors.danger.withValues(alpha: 0.22),
                    child: Text(
                      'Jeżeli procedura nie przynosi efektu w ciągu 5 minut, '
                      'aktywuj SOS i przejdź do uniwersalnej procedury eskalacji. '
                      'Nie podejmuj krytycznych decyzji w pojedynkę.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.55,
                        color: Colors.white.withValues(alpha: 0.66),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard({required this.protocol, required this.onTap});

  final EmergencyProtocolCollection protocol;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
      color: protocol.isCritical
          ? AppColors.danger.withValues(alpha: 0.10)
          : null,
      borderColor: protocol.isCritical
          ? AppColors.danger.withValues(alpha: 0.30)
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: (protocol.isCritical ? AppColors.danger : AppColors.cyan)
                  .withValues(alpha: 0.13),
            ),
            child: Icon(
              protocol.isCritical
                  ? Icons.warning_amber_rounded
                  : Icons.assignment_outlined,
              size: 22,
              color: protocol.isCritical ? AppColors.danger : AppColors.cyan,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        protocol.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (protocol.isCritical)
                      const StatusPill(
                        label: 'Krytyczna',
                        color: AppColors.danger,
                        compact: true,
                      ),
                    if (protocol.sosActive) ...[
                      const SizedBox(width: 5),
                      const StatusPill(
                        label: 'SOS',
                        color: AppColors.amber,
                        compact: true,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  protocol.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.56),
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Text(
                      '${protocol.instructions.length} KROKÓW',
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w700,
                        color: (protocol.isCritical ? AppColors.danger : AppColors.cyan)
                            .withValues(alpha: 0.86),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Colors.white.withValues(alpha: 0.35),
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
