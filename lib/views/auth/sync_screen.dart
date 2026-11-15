import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/hud_route.dart';
import '../../widgets/hynapse_mark.dart';
import '../dashboard/main_shell.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen>
    with SingleTickerProviderStateMixin {
  static const _messages = [
    'Nawiązywanie połączenia ze stacją...',
    'Pobieranie profilu operatora...',
    'Kalibracja modułów poznawczych...',
    'Weryfikacja procedur awaryjnych...',
    'Synchronizacja zakończona.',
  ];

  late final AnimationController _pulse;
  Timer? _messageTimer;
  Timer? _navigationTimer;
  int _messageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _messageTimer = Timer.periodic(const Duration(milliseconds: 640), (timer) {
      if (!mounted) return;
      setState(() {
        _messageIndex = math.min(_messageIndex + 1, _messages.length - 1);
      });
    });

    _navigationTimer = Timer(const Duration(milliseconds: 3150), _finish);
  }

  Future<void> _finish() async {
    try {
      await ref.read(sessionProvider.notifier).synchronize();
    } catch (_) {
      // Prototyp działa również w trybie offline — synchronizacja jest opcjonalna.
    }
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      hudRoute(const MainShell()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    _messageTimer?.cancel();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showGrid: false,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proszę czekać...',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 46,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Aktualizujemy dane aplikacji z danymi serwera.\n'
                    'Może to zająć kilka chwil.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.72),
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 52),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: AnimatedBuilder(
                      animation: _pulse,
                      builder: (context, child) {
                        final t = _pulse.value;
                        return Transform.rotate(
                          angle: t * math.pi * 2,
                          child: Transform.scale(
                            scale: 0.78 + math.sin(t * math.pi * 2).abs() * 0.22,
                            child: child,
                          ),
                        );
                      },
                      child: const CustomPaint(painter: _SparklePainter()),
                    ),
                  ),
                  const SizedBox(height: 44),
                  SizedBox(
                    width: 240,
                    child: Column(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 2900),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 5,
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.10),
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.cyan,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          child: Text(
                            _messages[_messageIndex],
                            key: ValueKey(_messageIndex),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 0.3,
                              color: Colors.white.withValues(alpha: 0.54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 52),
                  Opacity(
                    opacity: 0.28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HynapseMark(size: 20, glow: false),
                        const SizedBox(width: 8),
                        Text(
                          'HYNAPSE / LOKALNA STACJA',
                          style: TextStyle(
                            fontSize: 9,
                            letterSpacing: 1.4,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
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

class _SparklePainter extends CustomPainter {
  const _SparklePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(
        colors: [Colors.white, Color(0xFFD9F9FF)],
      ).createShader(Offset.zero & size);

    final main = Path()
      ..moveTo(center.dx, center.dy - size.height * 0.46)
      ..quadraticBezierTo(
        center.dx + size.width * 0.075,
        center.dy - size.height * 0.08,
        center.dx + size.width * 0.30,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx + size.width * 0.075,
        center.dy + size.height * 0.08,
        center.dx,
        center.dy + size.height * 0.46,
      )
      ..quadraticBezierTo(
        center.dx - size.width * 0.075,
        center.dy + size.height * 0.08,
        center.dx - size.width * 0.30,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx - size.width * 0.075,
        center.dy - size.height * 0.08,
        center.dx,
        center.dy - size.height * 0.46,
      )
      ..close();
    canvas.drawPath(main, paint);

    final smallCenter = Offset(
      center.dx + size.width * 0.31,
      center.dy - size.height * 0.30,
    );
    final small = Path()
      ..moveTo(smallCenter.dx, smallCenter.dy - size.height * 0.16)
      ..quadraticBezierTo(
        smallCenter.dx + size.width * 0.035,
        smallCenter.dy - size.height * 0.035,
        smallCenter.dx + size.width * 0.11,
        smallCenter.dy,
      )
      ..quadraticBezierTo(
        smallCenter.dx + size.width * 0.035,
        smallCenter.dy + size.height * 0.035,
        smallCenter.dx,
        smallCenter.dy + size.height * 0.16,
      )
      ..quadraticBezierTo(
        smallCenter.dx - size.width * 0.035,
        smallCenter.dy + size.height * 0.035,
        smallCenter.dx - size.width * 0.11,
        smallCenter.dy,
      )
      ..quadraticBezierTo(
        smallCenter.dx - size.width * 0.035,
        smallCenter.dy - size.height * 0.035,
        smallCenter.dx,
        smallCenter.dy - size.height * 0.16,
      )
      ..close();
    canvas.drawPath(small, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
