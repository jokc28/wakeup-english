import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Primary - Warm Orange
  static const Color primary = Color(0xFFFF8C00);
  static const Color primaryLight = Color(0xFFFFD700);
  static const Color primaryDark = Color(0xFFE07800);
  static const Color primarySurface = Color(0xFFFFF3E0);

  // Gradient
  static const Color gradientStart = Color(0xFFFFD700);
  static const Color gradientEnd = Color(0xFFFF8C00);

  // Action - Green CTA (Duolingo green)
  static const Color action = Color(0xFF58CC02);
  static const Color actionLight = Color(0xFFD7FFB8);
  static const Color actionDark = Color(0xFF43A800);

  // Accent — alias to action for backward compat
  static const Color accent = action;
  static const Color accentLight = actionLight;
  static const Color accentDark = actionDark;

  // Secondary — kept for legacy references
  static const Color secondary = Color(0xFFFF6F61);
  static const Color secondaryLight = Color(0xFFFF9E94);
  static const Color secondaryDark = Color(0xFFE54B3C);

  // Background colors - warm but neutral enough for repeated daily use
  static const Color backgroundLight = Color(0xFFF8FAF7);
  static const Color backgroundDark = Color(0xFF1A1712);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceSoftLight = Color(0xFFF1F6EF);
  static const Color surfaceWarmLight = Color(0xFFFFF6E6);
  static const Color surfaceDark = Color(0xFF2A2520);
  static const Color outlineLight = Color(0xFFE2E8DD);
  static const Color shadowWarm = Color(0x332D2006);

  // Text colors - Warm tones
  static const Color textPrimaryLight = Color(0xFF2D2006);
  static const Color textSecondaryLight = Color(0xFF6E5E42);
  static const Color textPrimaryDark = Color(0xFFFFF8ED);
  static const Color textSecondaryDark = Color(0xFFB0A590);

  // Status colors
  static const Color success = Color(0xFF58CC02);
  static const Color error = Color(0xFFFF4B4B);
  static const Color warning = Color(0xFFFFC800);
  static const Color info = Color(0xFF1CB0F6);

  // Alarm colors
  static const Color alarmActive = Color(0xFFFF8C00);
  static const Color alarmInactive = Color(0xFFB8B0A0);

  // Quiz colors - Duolingo-inspired vibrant feedback
  static const Color quizCorrect = Color(0xFF58CC02);
  static const Color quizCorrectBg = Color(0xFFD7FFB8);
  static const Color quizIncorrect = Color(0xFFFF4B4B);
  static const Color quizIncorrectBg = Color(0xFFFFE0E0);
  static const Color quizOption = Color(0xFFFFF8ED);
  static const Color quizOptionSelected = Color(0xFFFFEDD0);
  static const Color quizOptionBorder = Color(0xFFE8DCC8);
  static const Color quizStreak = Color(0xFFFFC800);
}
