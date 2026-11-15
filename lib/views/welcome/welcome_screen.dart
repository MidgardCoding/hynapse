import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hynapse_mark.dart';
import '../auth/auth_id_screen.dart';
import '../emergency/emergency_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final markSize = (size.width * 0.44).clamp(140.0, 210.0);
    final horizontal = (size.width * 0.075).clamp(22.0, 44.0);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          _Entrance(
                            delay: 0,
                            child: Column(
                              children: [
                                Text(
                                  'Hynapse',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        fontSize: 50,
                                        letterSpacing: -0.5,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Nowy wymiar testów poznawczych',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Colors.white.withValues(alpha: 0.82),
                                            fontSize: 17,
                                          ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.07),
                          _Entrance(
                            delay: 120,
                            child: Hero(
                              tag: 'hynapse-mark',
                              child: Center(
                                child: HynapseMark(size: markSize),
                              ),
                            ),
                          ),
                          const Spacer(),
                          _Entrance(
                            delay: 220,
                            child: Column(
                              children: [
                                Text(
                                  'Wybierz:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const SizedBox(height: 14),
                                _WelcomeActions(
                                  onAuthorize: () {
                                    Navigator.of(context).push(
                                      hudRoute(const AuthIdScreen()),
                                    );
                                  },
                                  onExit: _showExitDialog,
                                ),
                                const SizedBox(height: 18),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      hudRoute(const EmergencyScreen()),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                  ),
                                  child: Text(
                                    'Tryb awaryjny',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Colors.white.withValues(alpha: 0.7),
                                      fontSize: 15,
                                      color: Colors.white.withValues(alpha: 0.86),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          Text(
                            'Hynapse Prototype\nVersion 0.1.0 (HT-1)',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.42),
                                  height: 1.3,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showExitDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Zakończyć sesję?'),
          content: const Text(
            'Aplikacja zostanie zamknięta. Lokalne dane pozostaną zapisane na urządzeniu.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Anuluj'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              child: const Text('Wyjdź'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      await SystemNavigator.pop();
    }
  }
}

class _WelcomeActions extends StatelessWidget {
  const _WelcomeActions({
    required this.onAuthorize,
    required this.onExit,
  });

  final VoidCallback onAuthorize;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00BFCB), Color(0xFF00A6B5)],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x4400E5F3),
              blurRadius: 26,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _ActionHalf(
                label: 'Autoryzacja',
                onTap: onAuthorize,
              ),
            ),
            Container(width: 1.5, color: Colors.black.withValues(alpha: 0.70)),
            Expanded(
              child: _ActionHalf(
                label: 'Wyjdź',
                onTap: onExit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionHalf extends StatelessWidget {
  const _ActionHalf({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _Entrance extends StatelessWidget {
  const _Entrance({required this.child, required this.delay});

  final Widget child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 700 + delay),
      curve: Interval(
        delay / (700 + delay),
        1,
        curve: Curves.easeOutCubic,
      ),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
