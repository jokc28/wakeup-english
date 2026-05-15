import 'package:flutter/material.dart';

/// 옥모닝 color tokens. Sunrise Orange family with Duolingo-green success accent.
abstract class AppColors {
  // Primary — Sunrise Orange
  static const Color primary = Color(0xFFFF6B1A);
  static const Color primaryLight = Color(0xFFFFB347);
  static const Color primaryDark = Color(0xFFD9531A);
  static const Color primarySurface = Color(0xFFFFF1E0);

  // Gradient endpoints
  static const Color gradientStart = primaryLight;
  static const Color gradientEnd = primary;

  // Action / success — Duolingo green retained for streak/quiz correct
  static const Color action = Color(0xFF58CC02);
  static const Color actionLight = Color(0xFFD7FFB8);
  static const Color actionDark = Color(0xFF43A800);

  // Accent aliases (back-compat — same as action)
  static const Color accent = action;
  static const Color accentLight = actionLight;
  static const Color accentDark = actionDark;

  // Secondary — coral, kept for occasional accent use
  static const Color secondary = Color(0xFFFF6F61);
  static const Color secondaryLight = Color(0xFFFF9E94);
  static const Color secondaryDark = Color(0xFFE54B3C);

  // Backgrounds — slightly warmer cream, near-white
  static const Color backgroundLight = Color(0xFFFFFCF7);
  static const Color backgroundDark = Color(0xFF1A1712);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceSoftLight = Color(0xFFFFF1E0);
  static const Color surfaceWarmLight = Color(0xFFFFF6E6);
  static const Color surfaceDark = Color(0xFF2A2520);
  static const Color outlineLight = Color(0xFFEEDEC8);
  static const Color shadowWarm = Color(0x331F1108);

  // Text — deeper warm tones for higher contrast
  static const Color textPrimaryLight = Color(0xFF1F1108);
  static const Color textSecondaryLight = Color(0xFF6E5E42);
  static const Color textTertiaryLight = Color(0xFFB59B7A);
  static const Color textPrimaryDark = Color(0xFFFFF8ED);
  static const Color textSecondaryDark = Color(0xFFB0A590);

  // Status
  static const Color success = action;
  static const Color error = Color(0xFFE63946);
  static const Color warning = Color(0xFFFFC800);
  static const Color info = Color(0xFF4FA5D4);

  // Alarm states
  static const Color alarmActive = primary;
  static const Color alarmInactive = Color(0xFFB8B0A0);

  // Quiz feedback — keep semantics, refresh hues for the new palette
  static const Color quizCorrect = action;
  static const Color quizCorrectBg = actionLight;
  static const Color quizIncorrect = error;
  static const Color quizIncorrectBg = Color(0xFFFFE0E3);
  static const Color quizOption = Color(0xFFFFF6E6);
  static const Color quizOptionSelected = Color(0xFFFFE6CC);
  static const Color quizOptionBorder = Color(0xFFE8D3B0);
  static const Color quizStreak = warning;
}
