import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';

class StreakData {
  final int currentStreak;
  final int maxStreak;
  final DateTime? lastCompletedDate;

  const StreakData({
    this.currentStreak = 0,
    this.maxStreak = 0,
    this.lastCompletedDate,
  });
}

class StreakService {
  static Future<StreakData> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(AppStrings.prefStreakCurrent) ?? 0;
    final max = prefs.getInt(AppStrings.prefStreakMax) ?? 0;
    final lastDateStr = prefs.getString(AppStrings.prefStreakLastDate);
    final lastDate =
        lastDateStr != null ? DateTime.tryParse(lastDateStr) : null;

    return StreakData(
      currentStreak: current,
      maxStreak: max,
      lastCompletedDate: lastDate,
    );
  }

  static Future<StreakData> recordCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final lastDateStr = prefs.getString(AppStrings.prefStreakLastDate);
    final lastDate =
        lastDateStr != null ? DateTime.tryParse(lastDateStr) : null;

    var current = prefs.getInt(AppStrings.prefStreakCurrent) ?? 0;
    var max = prefs.getInt(AppStrings.prefStreakMax) ?? 0;

    if (lastDate != null) {
      final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
      final difference = today.difference(lastDay).inDays;

      if (difference == 0) {
        // Already counted today — no change
        return StreakData(
          currentStreak: current,
          maxStreak: max,
          lastCompletedDate: lastDate,
        );
      } else if (difference == 1) {
        // Consecutive day — increment streak
        current += 1;
      } else {
        // Streak broken — reset to 1
        current = 1;
      }
    } else {
      // First ever completion
      current = 1;
    }

    if (current > max) {
      max = current;
    }

    await prefs.setInt(AppStrings.prefStreakCurrent, current);
    await prefs.setInt(AppStrings.prefStreakMax, max);
    await prefs.setString(
        AppStrings.prefStreakLastDate, today.toIso8601String());

    return StreakData(
      currentStreak: current,
      maxStreak: max,
      lastCompletedDate: today,
    );
  }

  static Future<void> clearStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.prefStreakCurrent);
    await prefs.remove(AppStrings.prefStreakMax);
    await prefs.remove(AppStrings.prefStreakLastDate);
  }
}
