import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      primary: AppColors.cyan,
      secondary: AppColors.teal,
      surface: AppColors.surface,
      error: AppColors.danger,
      onPrimary: Color(0xFF00171A),
      onSecondary: Color(0xFF00171A),
      onSurface: AppColors.textPrimary,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'SansExpanded',
      splashFactory: InkSparkle.splashFactory,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        fontFamily: 'SansExpanded',
      ).copyWith(
        displayLarge: _bungee(52, FontWeight.w700, height: 0.95),
        displayMedium: _bungee(42, FontWeight.w700, height: 1),
        displaySmall: _bungee(34, FontWeight.w700, height: 1.05),
        headlineLarge: _bungee(30, FontWeight.w700, height: 1.05),
        headlineMedium: _bungee(26, FontWeight.w700, height: 1.1),
        headlineSmall: _bungee(22, FontWeight.w700, height: 1.15),
        titleLarge: _bungee(20, FontWeight.w700, letterSpacing: 1.1),
        titleMedium: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        titleSmall: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 16,
          height: 1.45,
          color: AppColors.textPrimary,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 14,
          height: 1.45,
          color: AppColors.textSecondary,
        ),
        bodySmall: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 12,
          height: 1.4,
          color: AppColors.textMuted,
        ),
        labelLarge: const TextStyle(
          fontFamily: 'SansExpanded',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x66333C67),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.white, width: 1.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.white, width: 1.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.cyan, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.cyan,
          foregroundColor: const Color(0xFF00171A),
          minimumSize: const Size(0, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'SansExpanded',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontFamily: 'SansExpanded',
        ),
      ),
    );
  }

  static TextStyle _bungee(
    double size,
    FontWeight weight, {
    double? height,
    double letterSpacing = 0.5,
  }) {
    return TextStyle(
      fontFamily: 'Bungee',
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: AppColors.textPrimary,
    );
  }
}
