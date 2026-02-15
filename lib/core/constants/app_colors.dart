import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4A42E8);

  // Secondary colors
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color secondaryLight = Color(0xFFFF9999);
  static const Color secondaryDark = Color(0xFFE84A4A);

  // Background colors
  static const Color backgroundLight = Color(0xFFF5F5F7);
  static const Color backgroundDark = Color(0xFF1C1C1E);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2C2C2E);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF1C1C1E);
  static const Color textSecondaryLight = Color(0xFF8E8E93);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF98989D);

  // Status colors
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFFCC00);

  // Alarm colors
  static const Color alarmActive = Color(0xFF6C63FF);
  static const Color alarmInactive = Color(0xFF8E8E93);

  // Quiz colors
  static const Color quizCorrect = Color(0xFF34C759);
  static const Color quizIncorrect = Color(0xFFFF3B30);
  static const Color quizOption = Color(0xFFF2F2F7);
  static const Color quizOptionSelected = Color(0xFFE8E7FF);
}
