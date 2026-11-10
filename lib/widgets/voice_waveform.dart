import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class VoiceWaveform extends StatefulWidget {
  const VoiceWaveform({
    super.key,
    required this.active,
    this.color = Colors.white,
    this.barCount = 24,
  });

  final bool active;
  final Color color;
  final int barCount;

  @override
  State<VoiceWaveform> createState() => _VoiceWaveformState();
}

class _VoiceWaveformState extends State<VoiceWaveform>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    if (widget.active) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant VoiceWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.active && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _WaveformPainter(
            progress: _controller.value,
            active: widget.active,
            color: widget.color,
            barCount: widget.barCount,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _WaveformPainter extends CustomPainter {
  _WaveformPainter({
    required this.progress,
    required this.active,
    required this.color,
    required this.barCount,
  });

  final double progress;
  final bool active;
  final Color color;
  final int barCount;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(3, size.width / (barCount * 2.1))
      ..color = color;
    final spacing = size.width / barCount;
    final maxHeight = size.height * 0.72;

    for (var i = 0; i < barCount; i++) {
      final normalized = i / (barCount - 1);
      final envelope = 0.45 + 0.55 * math.sin(normalized * math.pi);
      final waveA = math.sin(progress * math.pi * 2 + i * 0.8);
      final waveB = math.sin(progress * math.pi * 4.1 + i * 0.37);
      final idle = 0.18 + (math.sin(i * 1.5) * 0.06).abs();
      final amplitude = active
          ? (idle + (waveA * 0.28 + waveB * 0.18).abs()) * envelope
          : idle;
      final height = (maxHeight * amplitude).clamp(6.0, maxHeight);
      final x = spacing * i + spacing / 2;
      final centerY = size.height / 2;
      paint.color = color.withValues(alpha: 0.75 + envelope * 0.25);
      canvas.drawLine(
        Offset(x, centerY - height / 2),
        Offset(x, centerY + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.active != active ||
        oldDelegate.color != color;
  }
}

class WaveformOrb extends StatelessWidget {
  const WaveformOrb({
    super.key,
    required this.active,
    required this.diameter,
    this.child,
  });

  final bool active;
  final double diameter;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.25, -0.35),
          radius: 1.1,
          colors: [
            Color(0xFF8E174D),
            Color(0xFF4A1459),
            Color(0xFF181334),
            Color(0xFF10101A),
          ],
          stops: [0, 0.32, 0.72, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: active ? 0.20 : 0.06),
            blurRadius: diameter * 0.16,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: -diameter * 0.1,
            bottom: -diameter * 0.08,
            child: Container(
              width: diameter * 0.7,
              height: diameter * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF35A85F).withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -diameter * 0.08,
            top: -diameter * 0.04,
            child: Container(
              width: diameter * 0.6,
              height: diameter * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6E3BFF).withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: diameter * 0.13),
            child: VoiceWaveform(active: active, barCount: 22),
          ),
          ?child,
        ],
      ),
    );
  }
}
