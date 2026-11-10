import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/emergency_protocol_collection.dart';
import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/hud_button.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hud_scaffold.dart';
import '../../widgets/section_title.dart';
import 'box_breathing_screen.dart';

class EmergencyDetailScreen extends ConsumerStatefulWidget {
  const EmergencyDetailScreen({super.key, required this.protocol});

  final EmergencyProtocolCollection protocol;

  @override
  ConsumerState<EmergencyDetailScreen> createState() =>
      _EmergencyDetailScreenState();
}

class _EmergencyDetailScreenState extends ConsumerState<EmergencyDetailScreen> {
  late bool _sosActive;
  bool _updating = false;

  bool get _isPanic => widget.protocol.title.toLowerCase().contains('paniki');

  @override
  void initState() {
    super.initState();
    _sosActive = widget.protocol.sosActive;
  }

  Future<void> _toggleSos() async {
    if (_updating) return;
    if (_sosActive) {
      setState(() => _updating = true);
      await ref
          .read(repositoryProvider)
          .setSosStatus(widget.protocol, false);
      ref.invalidate(emergencyProtocolsProvider);
      if (!mounted) return;
      setState(() {
        _sosActive = false;
        _updating = false;
      });
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          icon: const Icon(
            Icons.wifi_tethering_rounded,
            color: AppColors.danger,
            size: 34,
          ),
          title: const Text('Aktywować SOS?'),
          content: const Text(
            'Sygnał ratunkowy zostanie zapisany lokalnie i ponowiony po '
            'odzyskaniu łączności. Centrum kontroli otrzyma identyfikator '
            'operatora oraz aktywną procedurę.',
            style: TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Anuluj'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
              ),
              child: const Text('Aktywuj SOS'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    setState(() => _updating = true);
    try {
      await ref.read(repositoryProvider).setSosStatus(widget.protocol, true);
      ref.invalidate(emergencyProtocolsProvider);
      if (!mounted) return;
      setState(() {
        _sosActive = true;
        _updating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOS aktywny. Sygnał zapisano lokalnie.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _updating = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nie udało się zapisać statusu SOS.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HudScaffold(
      title: 'Procedura awaryjna',
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
              Row(
                children: [
                  StatusPill(
                    label: widget.protocol.categoryLabel,
                    color: AppColors.textSecondary,
                    icon: Icons.folder_outlined,
                    compact: true,
                  ),
                  const SizedBox(width: 8),
                  if (widget.protocol.isCritical)
                    const StatusPill(
                      label: 'Krytyczna',
                      color: AppColors.danger,
                      compact: true,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.protocol.title.toUpperCase(),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 35,
                      height: 1.05,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.protocol.summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.68),
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
              _SosCard(
                active: _sosActive,
                loading: _updating,
                onPressed: _toggleSos,
              ),
              if (_isPanic) ...[
                const SizedBox(height: 14),
                GlassCard(
                  onTap: () {
                    Navigator.of(context).push(
                      hudRoute(const BoxBreathingScreen()),
                    );
                  },
                  padding: const EdgeInsets.all(16),
                  color: AppColors.cyan.withValues(alpha: 0.08),
                  borderColor: AppColors.cyan.withValues(alpha: 0.25),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cyan.withValues(alpha: 0.12),
                        ),
                        child: const Icon(
                          Icons.air_rounded,
                          color: AppColors.cyan,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Prowadzony oddech 4-4-4-4',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Uruchom animowany przewodnik Box Breathing',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.cyan,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 26),
              const SectionTitle(title: 'Instrukcje krok po kroku'),
              for (var i = 0; i < widget.protocol.instructions.length; i++)
                _StepTile(
                  index: i + 1,
                  text: widget.protocol.instructions[i],
                  isLast: i == widget.protocol.instructions.length - 1,
                  critical: widget.protocol.isCritical,
                ),
              const SizedBox(height: 18),
              HudButton(
                label: 'Zakończ procedurę',
                icon: Icons.check_rounded,
                color: AppColors.danger,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 12),
              Text(
                'Procedura zapisana w lokalnej bazie Isar. Wersja HT-1 · NASA TLX.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9.5,
                  color: Colors.white.withValues(alpha: 0.30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SosCard extends StatelessWidget {
  const _SosCard({
    required this.active,
    required this.loading,
    required this.onPressed,
  });

  final bool active;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: active
              ? [
                  AppColors.danger.withValues(alpha: 0.28),
                  AppColors.danger.withValues(alpha: 0.08),
                ]
              : [
                  Colors.white.withValues(alpha: 0.07),
                  Colors.white.withValues(alpha: 0.02),
                ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: active
              ? AppColors.danger.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? AppColors.danger.withValues(alpha: 0.22)
                  : Colors.white.withValues(alpha: 0.06),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: AppColors.danger.withValues(alpha: 0.45),
                        blurRadius: 20,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              Icons.wifi_tethering_rounded,
              color: active ? AppColors.danger : Colors.white.withValues(alpha: 0.6),
              size: 24,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  active ? 'SOS AKTYWNY' : 'SOS NIEAKTYWNY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: active ? AppColors.danger : Colors.white.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  active
                      ? 'Sygnał oczekuje na synchronizację'
                      : 'Aktywuj w sytuacji zagrożenia życia',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.50),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 44,
            child: FilledButton(
              onPressed: loading ? null : onPressed,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                backgroundColor:
                    active ? Colors.white.withValues(alpha: 0.10) : AppColors.danger,
                foregroundColor: active ? AppColors.danger : Colors.white,
                side: active
                    ? BorderSide(color: AppColors.danger.withValues(alpha: 0.5))
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(active ? 'Wyłącz' : 'SOS'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.text,
    required this.isLast,
    required this.critical,
  });

  final int index;
  final String text;
  final bool isLast;
  final bool critical;

  @override
  Widget build(BuildContext context) {
    final color = critical ? AppColors.danger : AppColors.cyan;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 38,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.12),
                    border: Border.all(color: color.withValues(alpha: 0.45)),
                  ),
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontFamily: 'Bungee',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: color,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: color.withValues(alpha: 0.20),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16, top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
