import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/emergency_protocol_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import 'box_breathing_screen.dart';
import 'emergency_category_screen.dart';
import 'emergency_detail_screen.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  static const _categories = [
    _CategoryData(
      'health',
      'Problemy zdrowotne',
      'Urazy, panika, nagłe pogorszenie samopoczucia',
      Icons.medical_services_outlined,
    ),
    _CategoryData(
      'travel',
      'Problemy z podróżą',
      'EVA, orientacja, awaria środka transportu',
      Icons.explore_outlined,
    ),
    _CategoryData(
      'equipment',
      'Awaria narzędzi',
      'Systemy życia, ciśnienie, elektronika',
      Icons.build_outlined,
    ),
    _CategoryData(
      'supplies',
      'Brak zasobów',
      'Woda, żywność, energia, tlen',
      Icons.inventory_2_outlined,
    ),
    _CategoryData(
      'location',
      'Nieznana lokalizacja',
      'Utrata pozycji i łączności',
      Icons.location_off_outlined,
    ),
    _CategoryData(
      'auth',
      'Awaria autoryzacji',
      'Dostęp offline, konto, terminal',
      Icons.key_outlined,
    ),
    _CategoryData(
      'other',
      'Inny problem',
      'Uniwersalna procedura eskalacji',
      Icons.warning_amber_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final protocolsAsync = ref.watch(emergencyProtocolsProvider);
    final protocols = protocolsAsync.valueOrNull ?? const [];
    final sosActive = protocols.any((protocol) => protocol.sosActive);

    return HudScaffold(
      title: 'Tryb awaryjny',
      danger: true,
      accent: AppColors.danger,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        child: ContentWidth(
          maxWidth: 620,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              if (sosActive) ...[
                _SosBanner(protocols: protocols),
                const SizedBox(height: 14),
              ],
              Text(
                'Wybierz opcję:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 33,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Procedury działają offline. Wybierz kategorię lub szybką akcję.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.50),
                ),
              ),
              const SizedBox(height: 22),
              const _QuickAccessLabel(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _QuickAction(
                      icon: Icons.speed_rounded,
                      label: 'Spadek ciśnienia',
                      onTap: () => _openProtocol(
                        context,
                        protocols,
                        'Spadek ciśnienia w kabinie',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _QuickAction(
                      icon: Icons.air_rounded,
                      label: 'Atak paniki',
                      onTap: () {
                        Navigator.of(context).push(
                          hudRoute(const BoxBreathingScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _QuickAction(
                      icon: Icons.signal_wifi_off_rounded,
                      label: 'Utrata łączności',
                      onTap: () => _openProtocol(
                        context,
                        protocols,
                        'Utrata łączności',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GlassCard(
                padding: EdgeInsets.zero,
                radius: 24,
                color: Colors.black.withValues(alpha: 0.20),
                child: Column(
                  children: [
                    for (var i = 0; i < _categories.length; i++) ...[
                      _CategoryRow(
                        data: _categories[i],
                        onTap: () {
                          Navigator.of(context).push(
                            hudRoute(
                              EmergencyCategoryScreen(
                                category: _categories[i].key,
                                title: _categories[i].label,
                              ),
                            ),
                          );
                        },
                      ),
                      if (i < _categories.length - 1)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.white.withValues(alpha: 0.07),
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassCard(
                padding: const EdgeInsets.all(16),
                color: AppColors.danger.withValues(alpha: 0.08),
                borderColor: AppColors.danger.withValues(alpha: 0.25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.wifi_tethering_rounded,
                      color: AppColors.danger,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'W sytuacji bezpośredniego zagrożenia życia aktywuj SOS '
                        'w procedurze szczegółowej. Sygnał zostanie zapisany lokalnie '
                        'i ponowiony po odzyskaniu łączności.',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.5,
                          color: Colors.white.withValues(alpha: 0.64),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openProtocol(
    BuildContext context,
    List<EmergencyProtocolCollection> protocols,
    String title,
  ) {
    EmergencyProtocolCollection? protocol;
    for (final item in protocols) {
      if (item.title == title) {
        protocol = item;
        break;
      }
    }
    if (protocol == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trwa ładowanie procedury: $title')),
      );
      return;
    }
    Navigator.of(context).push(hudRoute(EmergencyDetailScreen(protocol: protocol)));
  }
}

class _QuickAccessLabel extends StatelessWidget {
  const _QuickAccessLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 15,
          color: AppColors.danger,
        ),
        const SizedBox(width: 9),
        Text(
          'SZYBKI DOSTĘP',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.46),
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          height: 104,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.14),
                AppColors.danger.withValues(alpha: 0.14),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.danger.withValues(alpha: 0.20),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const Spacer(),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10.5,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.data, required this.onTap});

  final _CategoryData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
                ),
                child: Icon(
                  data.icon,
                  size: 19,
                  color: Colors.white.withValues(alpha: 0.78),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Colors.white.withValues(alpha: 0.38),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.30),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SosBanner extends StatelessWidget {
  const _SosBanner({required this.protocols});

  final List<EmergencyProtocolCollection> protocols;

  @override
  Widget build(BuildContext context) {
    final active = protocols.where((p) => p.sosActive).toList();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_tethering_rounded, color: AppColors.danger),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SOS AKTYWNY · ${active.map((p) => p.title).join(', ')}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryData {
  const _CategoryData(this.key, this.label, this.subtitle, this.icon);

  final String key;
  final String label;
  final String subtitle;
  final IconData icon;
}
