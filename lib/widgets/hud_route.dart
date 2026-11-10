import 'package:flutter/material.dart';

Route<T> hudRoute<T>(
  Widget page, {
  Duration duration = const Duration(milliseconds: 480),
  Offset beginOffset = const Offset(0, 0.035),
  bool replace = false,
}) {
  final route = PageRouteBuilder<T>(
    transitionDuration: duration,
    reverseTransitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final fade = Tween<double>(begin: 0, end: 1).animate(curved);
      final offset = Tween<Offset>(begin: beginOffset, end: Offset.zero)
          .animate(curved);
      final scale = Tween<double>(begin: 0.985, end: 1).animate(curved);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: offset,
          child: ScaleTransition(scale: scale, child: child),
        ),
      );
    },
  );
  return route;
}
